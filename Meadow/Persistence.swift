import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Meadow")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        } else {
            // Configure store to work locally first, with optional iCloud sync
            guard let description = container.persistentStoreDescriptions.first else {
                print("Warning: No store description found")
                return
            }
            
            // Always use local store URL as primary
            description.url = localStoreURL
            
            // Enable history tracking for potential sync
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            
            // Only enable CloudKit sync if iCloud is available
            if isICloudContainerAvailable {
                print("iCloud is available - enabling CloudKit sync")
                description.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.OddOmens.Meadow")
            } else {
                print("iCloud is not available - running in local-only mode")
                description.cloudKitContainerOptions = nil
            }
            
            // Ensure store works offline
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }

        loadPersistentStores()
        
        // Configure view context for optimal offline/online behavior
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        // Set reasonable timeouts for network operations
        container.viewContext.stalenessInterval = 0.0
    }
    
    // Public method to check if CloudKit is available
    var isCloudKitEnabled: Bool {
        return isICloudContainerAvailable && container.persistentStoreDescriptions.first?.cloudKitContainerOptions != nil
    }

    private var localStoreURL: URL {
        guard let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Unable to access documents directory")
        }
        return storeURL.appendingPathComponent("Meadow.sqlite")
    }

    private var isICloudContainerAvailable: Bool {
        FileManager.default.ubiquityIdentityToken != nil
    }

    private func loadPersistentStores() {
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Error loading persistent store: \(error), \(error.userInfo)")
                
                // Check if it's a CloudKit-specific error
                if error.domain == "NSCocoaErrorDomain" && (error.code == 134060 || error.code == 134030) {
                    print("CloudKit error detected - disabling CloudKit and using local store only")
                    self.disableCloudKitAndRetry()
                } else {
                    // For other errors, attempt recovery
                    print("Attempting to recover by creating fresh local store...")
                    self.createFreshStore()
                }
            } else {
                print("✅ Persistent store loaded successfully")
                if self.isICloudContainerAvailable {
                    print("📱 iCloud sync is enabled")
                } else {
                    print("💾 Running in local-only mode")
                }
            }
        }
    }
    
    private func disableCloudKitAndRetry() {
        print("Disabling CloudKit and retrying with local store only...")
        
        guard let description = container.persistentStoreDescriptions.first else { return }
        description.cloudKitContainerOptions = nil
        description.url = localStoreURL
        
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("Failed to load even without CloudKit: \(error)")
                self.createFreshStore()
            } else {
                print("✅ Successfully loaded local store without CloudKit")
            }
        }
    }

    private func fallbackToLocalStore() {
        print("Falling back to local-only store...")
        let description = NSPersistentStoreDescription(url: localStoreURL)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.cloudKitContainerOptions = nil // Explicitly disable CloudKit

        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("❌ Critical error loading local store: \(error), \(error.userInfo)")
                // Last resort: try to create a fresh store
                self.createFreshStore()
            } else {
                print("✅ Successfully loaded local store as fallback")
            }
        }
    }
    
    private func createFreshStore() {
        print("🔧 Attempting to create fresh store...")
        
        // Remove existing store files
        let fileManager = FileManager.default
        let storeURL = localStoreURL
        
        do {
            // Remove all related files
            try? fileManager.removeItem(at: storeURL)
            try? fileManager.removeItem(at: storeURL.deletingPathExtension().appendingPathExtension("sqlite-shm"))
            try? fileManager.removeItem(at: storeURL.deletingPathExtension().appendingPathExtension("sqlite-wal"))
            
            print("🗑️ Removed corrupted store files")
        }
        
        // Create new store description - local only, no CloudKit
        let description = NSPersistentStoreDescription(url: storeURL)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.cloudKitContainerOptions = nil // Ensure no CloudKit
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (_, error) in
            if let error = error as NSError? {
                print("❌ Failed to create fresh store: \(error), \(error.userInfo)")
                // At this point, we have to fail
                fatalError("Unable to load or create persistent store: \(error)")
            } else {
                print("✅ Successfully created fresh local store")
            }
        }
    }
}

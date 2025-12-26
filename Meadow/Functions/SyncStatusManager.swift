import SwiftUI
import CoreData
import Combine

class SyncStatusManager: ObservableObject {
    @Published var isSyncing: Bool = false
    @Published var lastSyncDate: Date?
    @Published var syncError: String?
    @Published var isCloudKitAvailable: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        checkCloudKitAvailability()
        setupNotifications()
    }
    
    private func checkCloudKitAvailability() {
        isCloudKitAvailable = FileManager.default.ubiquityIdentityToken != nil
    }
    
    private func setupNotifications() {
        // Listen for CloudKit sync notifications
        NotificationCenter.default.publisher(for: NSPersistentCloudKitContainer.eventChangedNotification)
            .sink { [weak self] notification in
                self?.handleSyncNotification(notification)
            }
            .store(in: &cancellables)
        
        // Listen for iCloud account changes
        NotificationCenter.default.publisher(for: NSUbiquityIdentityDidChange)
            .sink { [weak self] _ in
                self?.checkCloudKitAvailability()
            }
            .store(in: &cancellables)
    }
    
    private func handleSyncNotification(_ notification: Notification) {
        guard let event = notification.userInfo?[NSPersistentCloudKitContainer.eventNotificationUserInfoKey] as? NSPersistentCloudKitContainer.Event else {
            return
        }
        
        DispatchQueue.main.async {
            switch event.type {
            case .setup:
                print("CloudKit setup event")
            case .import:
                self.isSyncing = true
                print("CloudKit import started")
            case .export:
                self.isSyncing = true
                print("CloudKit export started")
            @unknown default:
                break
            }
            
            if event.endDate != nil {
                self.isSyncing = false
                self.lastSyncDate = Date()
                
                if let error = event.error {
                    self.syncError = error.localizedDescription
                    print("CloudKit sync error: \(error)")
                } else {
                    self.syncError = nil
                    print("CloudKit sync completed successfully")
                }
            }
        }
    }
}

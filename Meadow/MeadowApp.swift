import SwiftUI
import StoreKit

enum CurrentView {
    case main
}

class NavigationState: ObservableObject {
    @Published var currentView: CurrentView = .main
}

@main
struct MeadowApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var navigationState = NavigationState()
    @StateObject private var userSettings = UserSettings()
    
    @AppStorage("launchCount") private var launchCount = 0
    @AppStorage("reviewPromptLastShown") private var reviewPromptLastShown = 0
    @AppStorage("userChoseToReviewLater") private var userChoseToReviewLater = false
    @AppStorage("userDeclinedToReview") private var userDeclinedToReview = false
    
    init() {
        _ = persistenceController.container.viewContext
        incrementLaunchCount()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(themeManager)
                .environmentObject(userSettings)
                .environmentObject(navigationState)
                .onAppear {
                    themeManager.applyTheme()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Adding delay for better user experience
                        checkAndPromptForReview()
                    }
                }
                .onOpenURL { url in
                    handleDeepLink(url: url)
                }
        }
    }
    
    private func incrementLaunchCount() {
        launchCount += 1
    }
    
    private func checkAndPromptForReview() {
        if launchCount == 2 || launchCount == 5 {
            DispatchQueue.main.async {
                guard let scene = UIApplication.shared.foregroundActiveScene else { return }
                
                if #available(iOS 18.0, *) {
                    // Use new AppStore API for iOS 18+
                    AppStore.requestReview(in: scene)
                } else {
                    // Fallback for older iOS versions
                    SKStoreReviewController.requestReview(in: scene)
                }
                
                reviewPromptLastShown = launchCount
            }
        }
    }
    
    private func handleDeepLink(url: URL) {
        guard url.scheme == "meadow", url.host == "main" else { return }
        navigationState.currentView = .main
    }
}

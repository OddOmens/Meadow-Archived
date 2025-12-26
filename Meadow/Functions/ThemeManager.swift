import SwiftUI
import Combine
import Foundation

// Simplified theme manager - always uses dark theme
class ThemeManager: ObservableObject {
    
    enum ThemeType: String {
        case dark
    }
    
    @Published var currentTheme: ThemeType = .dark
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        // Always set to dark theme
        currentTheme = .dark
        
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { [weak self] _ in
                self?.applyTheme()
            }
            .store(in: &cancellables)
        
        applyTheme()
    }
    
    func applyTheme() {
        // Always apply dark theme
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = .dark
        }
    }
}


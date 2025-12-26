import SwiftUI
import CoreData
import Combine

extension UserDefaults {
    func bool(forKey defaultName: String, defaultBool: Bool) -> Bool {
        if object(forKey: defaultName) == nil {
            return defaultBool
        }
        return bool(forKey: defaultName)
    }
}


class UserSettings: ObservableObject {
    @Published var showNavLabels: Bool = UserDefaults.standard.bool(forKey: "showNavLabels", defaultBool: true) {
        didSet {
            UserDefaults.standard.set(showNavLabels, forKey: "showNavLabels")
        }
    }
}

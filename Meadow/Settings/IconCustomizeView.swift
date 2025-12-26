import SwiftUI

struct AppIcon: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
    let isLocked: Bool
}

struct IconView: View {
    let icon: AppIcon
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image("Preview" + icon.imageName) // Use preview images for display
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .cornerRadius(15)
            VStack(alignment: .leading) {
                Text(icon.name)
                    .font(.headline)
                    .bold()
                Text(icon.description)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading) // Left justified description text
            }
            Spacer()
            if icon.isLocked {
                Image(systemName: "lock.fill")
                    .foregroundColor(.red)
            } else if isSelected {
                Image("check")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 16, height: 16)
            }
        }
    }
}

struct IconPickerView: View {
    @State private var selectedIcon: AppIcon?
    @State private var isIconChangeSuccessful = false
    
    let icons = [
        AppIcon(name: "Default", description: "Classic vibes for your mental drive.", imageName: "AppIcon", isLocked: false),
        AppIcon(name: "Morning", description: "Start fresh with a bright session.", imageName: "AppIconMorning", isLocked: false),
        AppIcon(name: "Midnight", description: "Calm thoughts for late-night insights.", imageName: "AppIconMidnight", isLocked: false),
        AppIcon(name: "Winter", description: "Chill and think, it's therapeutic.", imageName: "AppIconWinter", isLocked: false),
        AppIcon(name: "Charcoal", description: "Bold sessions for intense reflections.", imageName: "AppIconCharcoal", isLocked: false),
        AppIcon(name: "Norse", description: "Rugged like therapy for the soul.", imageName: "AppIconNorse", isLocked: false),
        AppIcon(name: "Seaweed", description: "Deep and calm like an ocean's balm.", imageName: "AppIconSeaweed", isLocked: false),
        AppIcon(name: "Mint", description: "Fresh thoughts for a minty mindset.", imageName: "AppIconMint", isLocked: false),
        AppIcon(name: "Cherry Blossom", description: "Bloom your thoughts, feel the spring.", imageName: "AppIconCherryBlossom", isLocked: false),
        AppIcon(name: "Blueberry", description: "Sweet ideas for a fruitful mind.", imageName: "AppIconBlueberry", isLocked: false)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(icons) { icon in
                    Button(action: {
                        if !icon.isLocked {
                            selectedIcon = icon
                            saveSelectedIcon(icon)
                            
                            setAppIcon(to: icon.imageName == "AppIcon" ? nil : icon.imageName) { success in
                                if success {
                                    isIconChangeSuccessful = true
                                } else {
                                    isIconChangeSuccessful = false
                                    selectedIcon = nil
                                }
                            }
                        }
                    }) {
                        IconView(icon: icon, isSelected: selectedIcon == icon && isIconChangeSuccessful)
                    }
                }
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
        .navigationTitle("App Icons")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loadSelectedIcon()
        }
    }
    
    private func saveSelectedIcon(_ icon: AppIcon) {
        UserDefaults.standard.setValue(icon.imageName, forKey: "selectedIconName")
    }
    
    private func loadSelectedIcon() {
        if let savedIconName = UserDefaults.standard.string(forKey: "selectedIconName"),
           let savedIcon = icons.first(where: { $0.imageName == savedIconName }) {
            selectedIcon = savedIcon
            isIconChangeSuccessful = true
        }
    }
}

func setAppIcon(to iconName: String?, completion: @escaping (Bool) -> Void) {
    guard UIApplication.shared.supportsAlternateIcons else {
        completion(false)
        return
    }
    
    UIApplication.shared.setAlternateIconName(iconName) { error in
        if let error = error {
            print("Error setting alternate icon: \(error.localizedDescription)")
            completion(false)
        } else {
            print("Successfully changed app icon to: \(iconName ?? "default")")
            completion(true)
        }
    }
}

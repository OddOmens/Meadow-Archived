import SwiftUI
import CoreData
import CloudKit

struct SettingsView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var themeManager: ThemeManager
    
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.openURL) var openURL
    
    @State private var showVersionView = false
    @State private var showAboutView = false
    @State private var showHelpView = false
    @State private var showTermsView = false
    @State private var showPrivacyView = false
    
    @State private var showingDeleteOptions = false
    @State private var showingDeleteAllDataAlert = false
    @State private var showingDeleteSessionAlert = false
    @State private var showingDeleteTreatmentsAlert = false
    @State private var showingDeleteDiagnosesAlert = false
    @State private var showingDeleteThoughtsAlert = false
    @State private var showingDeleteProvidersAlert = false
    
    // Demo data alerts
    @State private var showingLoadAllDemoAlert = false
    @State private var showingLoadProvidersAlert = false
    @State private var showingLoadSessionsAlert = false
    @State private var showingLoadTreatmentsAlert = false
    @State private var showingLoadThoughtsAlert = false
    @State private var showingClearDemoAlert = false
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(ThemeColors.border)
                .frame(maxWidth: .infinity)
        
            List {
                Section(header: Text("Customize")) {
                    
                    Toggle(isOn: $userSettings.showNavLabels) {
                        HStack {
                            Image("gallery-thumbnails")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Navigation Labels")
                        }
                    }
                    
                    NavigationLink(destination: IconPickerView()) {
                        HStack {
                            Image("glasses")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Custom App Icon")
                        }
                    }
                    
                }
                
                Section(header: Text("App Data")) {
                    VStack {
                        Button(action: {
                            showingDeleteOptions = true
                        }) {
                            HStack {
                                Image("trash")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(ThemeColors.textPrimary)
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                
                                Text("Select Data to Delete")
                            }
                        }
                        .sheet(isPresented: $showingDeleteOptions) {
                            VStack  (spacing: 0) {
                                Text("Delete User Data")
                                    .foregroundColor(ThemeColors.textPrimary) // Your custom color
                                    .font(.system(size: 16))
                                    .bold()
                            }
                            .frame(maxWidth: .infinity)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 50.0, style: .continuous).fill(.white))
                            .padding()
                            .padding(.bottom, -5)
                            
                            Divider().padding(.horizontal)
                            
                            Text ("Warning: Deleting user data will not only remove it from your local device, but from iCloud as well. There is no way to restore this information.")
                                .padding()
                            
                            Divider().padding(.horizontal)
                            
                            List {
                                Button(action: {
                                    showingDeleteAllDataAlert = true
                                }) {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(ThemeColors.textPrimary)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Delete All Data")
                                            .foregroundColor(ThemeColors.accent2)
                                    }
                                    .alert(isPresented: $showingDeleteAllDataAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete all of your data?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                deleteAllData()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                                
                                
                                Button(action: {
                                    showingDeleteSessionAlert = true
                                }) {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(ThemeColors.textPrimary)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Delete All Conversations")
                                            .foregroundColor(ThemeColors.accent2)
                                    }
                                    .alert(isPresented: $showingDeleteSessionAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete all of your conversations?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                deleteAllSessions()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                                
                                Button(action: {
                                    showingDeleteTreatmentsAlert = true
                                }) {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(ThemeColors.textPrimary)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Delete All Goals")
                                            .foregroundColor(ThemeColors.accent2)
                                    }
                                    .alert(isPresented: $showingDeleteTreatmentsAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete all of your goals?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                deleteAllTreatments()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                                
                                Button(action: {
                                    showingDeleteDiagnosesAlert = true
                                }) {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(ThemeColors.textPrimary)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Delete All Diagnoses")
                                            .foregroundColor(ThemeColors.accent2)
                                    }
                                    .alert(isPresented: $showingDeleteDiagnosesAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete all of your diagnoses?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                deleteAllDiagnoses()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                                
                                Button(action: {
                                    showingDeleteThoughtsAlert = true
                                }) {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(ThemeColors.textPrimary)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Delete All Thoughts")
                                            .foregroundColor(ThemeColors.accent2)
                                    }
                                    .alert(isPresented: $showingDeleteThoughtsAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete all of your thoughts?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                deleteAllThoughts()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                                
                                Button(action: {
                                    showingDeleteProvidersAlert = true
                                }) {
                                    HStack {
                                        Image("trash")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(ThemeColors.textPrimary)
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                        
                                        Text("Delete All Support Network")
                                            .foregroundColor(ThemeColors.accent2)
                                    }
                                    .alert(isPresented: $showingDeleteProvidersAlert) {
                                        Alert(
                                            title: Text("Are you sure you want to delete all of your support network?"),
                                            primaryButton: .destructive(Text("Delete")) {
                                                deleteAllProviders()
                                            },
                                            secondaryButton: .cancel()
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
                
                Section(header: Text("Help")) {
                    Button(action: {
                        if let url = URL(string: "mailto:support@example.com?subject=Meadow%20App%20Support&body=Hello,%20I%20need%20help%20with...") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image("mail")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text("Email Support")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://example.com") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image("message-square-question")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            Text("Help Center")

                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "mailto:support@example.com?subject=Meadow%20-%20Report%20an%20Issue&body=Please%20describe%20the%20issue...") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image("message-square-exclamation")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Report an issue")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "mailto:support@example.com?subject=Meadow%20-%20Feature%20Request&body=Please%20describe%20the%20feature...") {
                            openURL(url)
                        }
                    }) {
                        HStack {
                            Image("message-square-question")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)

                            Text("Request a feature")
                        }
                    }
                }
                
                Section(header: Text("About Meadow")) {
                    NavigationLink(destination: VersionView()) {
                        HStack {
                            Image("certificate-check")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text("Version")
                            Text("2025.12.1")
                        }
                    }
                }
                
                Section(header: Text("Privacy and Terms")) {
                    Button(action: {
                        if let url = URL(string: "https://example.com/privacy") {
                            openURL(url)
                        }
                    }){
                        HStack {
                            Image("memo-check")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text("Privacy Policy")
                        }
                    }
                    
                    Button(action: {
                        if let url = URL(string: "https://example.com/terms") {
                            openURL(url)
                        }
                    }){
                        HStack {
                            Image("memo-check")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(ThemeColors.textPrimary)
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                            
                            Text("Terms of Service")
                        }
                    }
                }
                
            }
            .listStyle(.inset)
            .padding(.bottom, 100)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    func deleteAllData() {
        deleteAllSessions()
        deleteAllDiagnoses()
        deleteAllTreatments()
        deleteAllThoughts()
        deleteAllProviders()
    }
    
    func deleteAllSessions() {
        let fetchRequest: NSFetchRequest<Session> = Session.fetchRequest()

        do {
            let sessionsToDelete = try managedObjectContext.fetch(fetchRequest)
            for sessions in sessionsToDelete {
                managedObjectContext.delete(sessions)
            }
            try managedObjectContext.save()
        } catch {
            print("Error deleting all sessions: \(error.localizedDescription)")
        }
    }
    
    func deleteAllTreatments() {
        let fetchRequest: NSFetchRequest<Treatment> = Treatment.fetchRequest()

        do {
            let treatmentsToDelete = try managedObjectContext.fetch(fetchRequest)
            for treatment in treatmentsToDelete {
                managedObjectContext.delete(treatment)
            }
            try managedObjectContext.save()
        } catch {
            print("Error deleting all treatments: \(error.localizedDescription)")
        }
    }
    
    func deleteAllDiagnoses() {
        let fetchRequest: NSFetchRequest<Disorder> = Disorder.fetchRequest()

        do {
            let diagnosesToDelete = try managedObjectContext.fetch(fetchRequest)
            for disorder in diagnosesToDelete {
                managedObjectContext.delete(disorder)
            }
            try managedObjectContext.save()
        } catch {
            print("Error deleting all diagnoses: \(error.localizedDescription)")
        }
    }
    
    func deleteAllThoughts() {
        let fetchRequest: NSFetchRequest<Thought> = Thought.fetchRequest()

        do {
            let thoughtsToDelete = try managedObjectContext.fetch(fetchRequest)
            for thought in thoughtsToDelete {
                managedObjectContext.delete(thought)
            }
            try managedObjectContext.save()
        } catch {
            print("Error deleting all thoughts: \(error.localizedDescription)")
        }
    }
    
    func deleteAllProviders() {
        let fetchRequest: NSFetchRequest<Provider> = Provider.fetchRequest()

        do {
            let providersToDelete = try managedObjectContext.fetch(fetchRequest)
            for provider in providersToDelete {
                managedObjectContext.delete(provider)
            }
            try managedObjectContext.save()
        } catch {
            print("Error deleting all providers: \(error.localizedDescription)")
        }
    }
}

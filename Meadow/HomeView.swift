import SwiftUI
import CoreData
import Foundation

// MARK: - Demo Data Helper
class DemoDataHelper {
    static func loadDemoData(context: NSManagedObjectContext) {
        clearAllData(context: context)
        let providers = createDemoProviders(context: context)
        createDemoSessions(context: context, providers: providers)
        createDemoTreatments(context: context)
        createDemoThoughts(context: context)
        do {
            try context.save()
            print("✅ Demo data loaded successfully")
        } catch {
            print("❌ Error saving demo data: \(error)")
        }
    }
    
    static func loadDemoProviders(context: NSManagedObjectContext) {
        _ = createDemoProviders(context: context)
        do {
            try context.save()
            print("✅ Demo providers loaded successfully")
        } catch {
            print("❌ Error saving demo providers: \(error)")
        }
    }
    
    static func loadDemoSessions(context: NSManagedObjectContext) {
        let providers = createDemoProviders(context: context)
        createDemoSessions(context: context, providers: providers)
        do {
            try context.save()
            print("✅ Demo sessions loaded successfully")
        } catch {
            print("❌ Error saving demo sessions: \(error)")
        }
    }
    
    static func loadDemoTreatments(context: NSManagedObjectContext) {
        createDemoTreatments(context: context)
        do {
            try context.save()
            print("✅ Demo treatments loaded successfully")
        } catch {
            print("❌ Error saving demo treatments: \(error)")
        }
    }
    
    static func loadDemoThoughts(context: NSManagedObjectContext) {
        createDemoThoughts(context: context)
        do {
            try context.save()
            print("✅ Demo thoughts loaded successfully")
        } catch {
            print("❌ Error saving demo thoughts: \(error)")
        }
    }
    
    static func clearDemoData(context: NSManagedObjectContext) {
        clearAllData(context: context)
        print("✅ All demo data cleared successfully")
    }
    
    private static func clearAllData(context: NSManagedObjectContext) {
        let entities = ["Provider", "Session", "Treatment", "Thought"]
        for entity in entities {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print("Error clearing \(entity): \(error)")
            }
        }
    }
    
    private static func createDemoProviders(context: NSManagedObjectContext) -> [Provider] {
        var providers: [Provider] = []
        let therapist = Provider(context: context)
        therapist.id = UUID()
        therapist.firstName = "Sarah"
        therapist.lastName = "Johnson"
        therapist.title = "Dr."
        therapist.type = "Therapist"
        therapist.email = "sarah.johnson@therapy.com"
        therapist.phoneNumber = "(555) 123-4567"
        therapist.website = "www.sarahjohnsontherapy.com"
        therapist.isActive = true
        therapist.notes = "Specializes in CBT and anxiety management"
        providers.append(therapist)
        
        let coach = Provider(context: context)
        coach.id = UUID()
        coach.firstName = "Marcus"
        coach.lastName = "Chen"
        coach.title = "none"
        coach.type = "Life Coach"
        coach.email = "marcus@lifecoaching.com"
        coach.phoneNumber = "(555) 234-5678"
        coach.isActive = true
        coach.notes = "Focus on career transitions and goal setting"
        providers.append(coach)
        
        let friend = Provider(context: context)
        friend.id = UUID()
        friend.firstName = "Alex"
        friend.lastName = "Rivera"
        friend.title = "none"
        friend.type = "Friend"
        friend.email = "alex.rivera@email.com"
        friend.phoneNumber = "(555) 345-6789"
        friend.isActive = true
        friend.notes = "Best friend since college, great listener"
        providers.append(friend)
        
        let mentor = Provider(context: context)
        mentor.id = UUID()
        mentor.firstName = "Jennifer"
        mentor.lastName = "Williams"
        mentor.title = "Prof."
        mentor.type = "Mentor"
        mentor.email = "j.williams@university.edu"
        mentor.isActive = true
        mentor.notes = "Career mentor, meets monthly"
        providers.append(mentor)
        
        let spiritual = Provider(context: context)
        spiritual.id = UUID()
        spiritual.firstName = "Michael"
        spiritual.lastName = "Thompson"
        spiritual.title = "Rev."
        spiritual.type = "Pastor"
        spiritual.email = "pastor.mike@church.org"
        spiritual.phoneNumber = "(555) 456-7890"
        spiritual.isActive = false
        spiritual.notes = "Former spiritual advisor, moved to another city"
        providers.append(spiritual)
        
        return providers
    }
    
    private static func createDemoSessions(context: NSManagedObjectContext, providers: [Provider]) {
        let calendar = Calendar.current
        let today = Date()
        
        let session1 = Session(context: context)
        session1.id = UUID()
        session1.therapist = "Dr. Sarah Johnson"
        session1.title = "Weekly Check-in"
        session1.date = calendar.date(byAdding: .day, value: -2, to: today)
        session1.time = "2:00 PM"
        session1.preMood = "Anxious"
        session1.postMood = "Calm"
        session1.purpose = "Discussed work stress and upcoming presentation"
        session1.advice = "Practice breathing exercises before meetings. Remember: progress over perfection."
        session1.notes = "Felt much better after talking through my concerns. Dr. Johnson suggested breaking down the presentation into smaller tasks."
        session1.count = 1.0
        
        let session2 = Session(context: context)
        session2.id = UUID()
        session2.therapist = "Marcus Chen"
        session2.title = "Career Planning"
        session2.date = calendar.date(byAdding: .day, value: -7, to: today)
        session2.time = "10:00 AM"
        session2.preMood = "Uncertain"
        session2.postMood = "Motivated"
        session2.purpose = "Career transition discussion"
        session2.advice = "Update LinkedIn profile, reach out to 3 contacts this week, research target companies"
        session2.notes = "Created action plan for career change. Marcus helped me identify transferable skills."
        session2.count = 1.0
        
        let session3 = Session(context: context)
        session3.id = UUID()
        session3.therapist = "Alex Rivera"
        session3.title = "Coffee Catch-up"
        session3.date = calendar.date(byAdding: .day, value: -5, to: today)
        session3.time = "11:30 AM"
        session3.preMood = "Stressed"
        session3.postMood = "Happy"
        session3.purpose = "Needed to vent about work and life"
        session3.advice = "Take more breaks, don't forget to have fun"
        session3.notes = "Alex always knows how to make me laugh. Reminded me that it's okay to not have everything figured out."
        session3.count = 1.0
        
        let session4 = Session(context: context)
        session4.id = UUID()
        session4.therapist = "Prof. Jennifer Williams"
        session4.title = "Monthly Mentorship"
        session4.date = calendar.date(byAdding: .day, value: -14, to: today)
        session4.time = "3:00 PM"
        session4.preMood = "Curious"
        session4.postMood = "Inspired"
        session4.purpose = "Discussed professional development and networking"
        session4.advice = "Attend industry conference next month, consider speaking at local meetup"
        session4.notes = "Jennifer shared her experience with career pivots. Very encouraging conversation."
        session4.count = 1.0
        
        let session5 = Session(context: context)
        session5.id = UUID()
        session5.therapist = "Dr. Sarah Johnson"
        session5.title = "Processing Change"
        session5.date = calendar.date(byAdding: .day, value: -21, to: today)
        session5.time = "2:00 PM"
        session5.preMood = "Overwhelmed"
        session5.postMood = "Hopeful"
        session5.purpose = "Dealing with major life changes"
        session5.advice = "Focus on what you can control. One day at a time."
        session5.notes = "Talked about accepting uncertainty. Dr. Johnson reminded me of how far I've come."
        session5.count = 1.0
    }
    
    private static func createDemoTreatments(context: NSManagedObjectContext) {
        let treatment1 = Treatment(context: context)
        treatment1.diagnosis = "Personal Growth"
        treatment1.goal = "Practice mindfulness daily"
        treatment1.desc = "Meditate for 10 minutes each morning. Track progress and notice improvements in stress levels."
        
        let treatment2 = Treatment(context: context)
        treatment2.diagnosis = "Career Development"
        treatment2.goal = "Complete career transition by end of year"
        treatment2.desc = "Update resume, network with professionals in target field, apply to 5 positions per week."
        
        let treatment3 = Treatment(context: context)
        treatment3.diagnosis = "Social Connection"
        treatment3.goal = "Strengthen relationships"
        treatment3.desc = "Reach out to friends and family weekly. Schedule regular catch-ups. Be more present in conversations."
        
        let treatment4 = Treatment(context: context)
        treatment4.diagnosis = "Mental Health"
        treatment4.goal = "Manage anxiety effectively"
        treatment4.desc = "Use breathing techniques when feeling anxious. Challenge negative thoughts. Maintain therapy schedule."
    }
    
    private static func createDemoThoughts(context: NSManagedObjectContext) {
        let thought1 = Thought(context: context)
        thought1.content = "Feeling grateful today. The conversation with Alex really helped me put things in perspective. Sometimes I forget that everyone struggles, not just me."
        thought1.diagnosis = "Gratitude"
        
        let thought2 = Thought(context: context)
        thought2.content = "Worried about the presentation next week. What if I mess up? But Dr. Johnson's advice about breaking it into smaller tasks is helping. I can do this."
        thought2.diagnosis = "Anxiety"
        
        let thought3 = Thought(context: context)
        thought3.content = "Looking back at my sessions, I can see real progress. Three months ago I couldn't imagine making this career change. Now I have a plan and I'm taking action."
        thought3.diagnosis = "Reflection"
        
        let thought4 = Thought(context: context)
        thought4.content = "Marcus said something that stuck with me: 'You don't have to be perfect, you just have to start.' Going to remember that when I feel stuck."
        thought4.diagnosis = "Motivation"
        
        let thought5 = Thought(context: context)
        thought5.content = "Change is hard. But it's also necessary. I'm learning to be okay with not having all the answers right now."
        thought5.diagnosis = "Processing"
    }
}

// MARK: - Keyboard Toolbar Extension
extension View {
    func keyboardToolbar() -> some View {
        self.toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.endEditing()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Dark Theme Constants
struct ThemeColors {
    static let primary = Color(hex: "FFFFFF")
    static let secondary = Color(hex: "2D3142")
    static let accent1 = Color(hex: "36756F")
    static let accent2 = Color(hex: "F6C177")
    static let accent3 = Color(hex: "A5D8FF")
    static let accent4 = Color(hex: "FFFFFF") // White
    static let background = Color(hex: "000000")
    static let cardBackground = Color(hex: "1C1C1E")
    static let textPrimary = Color(hex: "FFFFFF")
    static let textSecondary = Color(hex: "8E8E93")
    static let border = Color(hex: "38383A")
    
    // Card backgrounds for different purposes
    static let sleepBg = Color(hex: "1C2E2A")
    static let heartBg = Color(hex: "2E1C1C")
    static let awarenessBg = Color(hex: "2E261C")
    static let darkCard = Color(hex: "1C1C1E")
    
    // Navigation colors
    static let navInactive = Color(hex: "8E8E93")
    static let navActive = Color(hex: "FFFFFF")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ModernCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(ThemeColors.cardBackground)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

extension View {
    func modernCard() -> some View {
        modifier(ModernCard())
    }
}

//MARK: - Extensions
extension Client {
    public var disordersArray: [Disorder] {
        (disorders as? Set<Disorder> ?? []).sorted { $0.name ?? "" < $1.name ?? "" }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


//MARK: - Bottom Navigation
struct ContentView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var userSettings: UserSettings
    @EnvironmentObject var navigationState: NavigationState
    @StateObject private var therapistManager = TherapistManager()
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedTab = 0  // Changed to 0-based index
    @State private var isSwipeDisabled = false
    @State private var sessionsPath = NavigationPath()
    @State private var treatmentPath = NavigationPath()
    @State private var thoughtsPath = NavigationPath()
    @State private var providersPath = NavigationPath()
    @State private var profilePath = NavigationPath()
    @State private var isKeyboardVisible = false
    
    // State variables for ThoughtDetailView navigation
    @State private var selectedThought: Thought?
    @State private var showingNewThought = false

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack(path: $sessionsPath) {
                HomeView()
                    .environmentObject(therapistManager)
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .session(let session):
                            SessionView(session: session)
                        case .newSession:
                            SessionView(session: nil)
                        case .allSessions(let sessions):
                            AllSessionsView(sessions: sessions)
                        case .selectProvider(let selectedTherapist):
                            ProviderSelectionView(selectedTherapist: selectedTherapist)
                        default:
                            EmptyView()
                        }
                    }
            }
            .tag(0)

            NavigationStack(path: $treatmentPath) {
                TreatmentView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .goal(let goal):
                            NewGoalView(goalToEdit: .constant(goal))
                        case .newGoal:
                            NewGoalView(goalToEdit: .constant(nil))
                        default:
                            EmptyView()
                        }
                    }
            }
            .tag(1)

            NavigationStack(path: $thoughtsPath) {
                ThoughtsView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .thought(let thought):
                            ThoughtDetailView(thought: Binding(
                                get: { thought },
                                set: { _ in }
                            ))
                        case .newThought:
                            ThoughtDetailView(thought: Binding(
                                get: { nil },
                                set: { _ in }
                            ))
                        default:
                            EmptyView()
                        }
                    }
                    .sheet(item: $selectedThought) { thought in
                        ThoughtDetailView(thought: Binding(
                            get: { thought },
                            set: { _ in }
                        ))
                    }
                    .sheet(isPresented: $showingNewThought) {
                        ThoughtDetailView(thought: Binding(
                            get: { nil },
                            set: { _ in }
                        ))
                    }
            }
            .tag(2)

            NavigationStack(path: $providersPath) {
                ProvidersView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .editProvider(let provider):
                            NewProviderView(provider: provider)
                        case .newTherapist:
                            NewProviderView()
                        default:
                            EmptyView()
                        }
                    }
            }
            .tag(3)

            NavigationStack(path: $profilePath) {
                ProfileView()
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .profile:
                            ProfileView()
                        default:
                            EmptyView()
                        }
                    }
            }
            .tag(4)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            if !isKeyboardVisible {
                BottomNavigationBar(selectedTab: $selectedTab)
            }
        }
        .accentColor(.white)
        .preferredColorScheme(.dark)
        .onChange(of: selectedTab) { oldTab, newTab in
            // Clear navigation paths when switching tabs to return to root
            // Add delay to allow tab animation to complete first
            if oldTab != newTab {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    sessionsPath = NavigationPath()
                    treatmentPath = NavigationPath()
                    thoughtsPath = NavigationPath()
                    providersPath = NavigationPath()
                    profilePath = NavigationPath()
                }
            }
        }
        .onAppear {
            setupKeyboardNotifications()
        }
        .onDisappear {
            removeKeyboardNotifications()
        }
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { _ in
            withAnimation {
                isKeyboardVisible = true
            }
        }
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            withAnimation {
                isKeyboardVisible = false
            }
        }
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}

enum ProviderType: String, CaseIterable, Codable {
    case therapist = "Therapist"
    case psychologist = "Psychologist"
    case psychiatrist = "Psychiatrist"
    case counselor = "Counselor"
    case socialWorker = "Social Worker"
    case priest = "Priest"
    case pastor = "Pastor"
    case chaplain = "Chaplain"
    case rabbi = "Rabbi"
    case imam = "Imam"
    case spiritualAdvisor = "Spiritual Advisor"
    case lifecoach = "Life Coach"
    case nutritionist = "Nutritionist"
    case occupationalTherapist = "Occupational Therapist"
    case physicalTherapist = "Physical Therapist"
    case nurse = "Nurse"
    case mentor = "Mentor"
    case professor = "Professor"
    case supportGroup = "Support Group"
    case friend = "Friend"
    case family = "Family"
    
    var displayLabel: String {
        switch self {
        case .therapist, .psychologist, .psychiatrist, .counselor, .socialWorker, 
             .occupationalTherapist, .physicalTherapist, .nurse, .nutritionist:
            return "Healthcare Provider"
        case .priest, .pastor, .chaplain, .rabbi, .imam, .spiritualAdvisor:
            return "Spiritual Leader"
        case .lifecoach:
            return "Life Coach"
        case .friend:
            return "Friend"
        case .family:
            return "Family Member"
        case .supportGroup:
            return "Support Group"
        case .mentor:
            return "Mentor"
        case .professor:
            return "Academic Professional"
        }
    }
    
    var requiresCredentials: Bool {
        switch self {
        case .therapist, .psychologist, .psychiatrist, .counselor, .socialWorker,
             .lifecoach, .nutritionist, .occupationalTherapist, .physicalTherapist,
             .nurse, .mentor, .priest, .pastor, .chaplain, .rabbi, .imam, .spiritualAdvisor,
             .professor:
            return true
        default:
            return false
        }
    }
}

enum PersonTitle: String, CaseIterable, Codable {
    case none = "none"
    case dr = "Dr."
    case mr = "Mr."
    case mrs = "Mrs."
    case ms = "Ms."
    case miss = "Miss"
    case rev = "Rev."
    case fr = "Fr."
    case pastor = "Pastor"
    case rabbi = "Rabbi"
    case imam = "Imam"
    case prof = "Prof."
    
    var displayName: String {
        return self.rawValue
    }
}

struct ProvidersView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var animationId = UUID()
    
    @FetchRequest(
        entity: Provider.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Provider.lastName, ascending: true),
            NSSortDescriptor(keyPath: \Provider.firstName, ascending: true)
        ]
    ) private var providers: FetchedResults<Provider>
    
    var activeProviders: [Provider] {
        providers.filter { $0.isActive }
    }
    
    var inactiveProviders: [Provider] {
        providers.filter { !$0.isActive }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 12) {
                    if !activeProviders.isEmpty {
                        Text("Active Support")
                            .font(.headline)
                            .foregroundColor(ThemeColors.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 24)
                            .slideInTransition(.top)
                        
                        ForEach(activeProviders) { provider in
                            NavigationLink(value: NavigationDestination.editProvider(provider)) {
                                ProviderListRow(provider: provider)
                                    .transition(.asymmetric(insertion: .scale(scale: 0.9).combined(with: .opacity),
                                                         removal: .scale(scale: 0.9).combined(with: .opacity)))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                        }
                    }
                    
                    if !inactiveProviders.isEmpty {
                        Text("Past Support")
                            .font(.headline)
                            .foregroundColor(ThemeColors.textSecondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top, 24)
                            .slideInTransition(.top)
                        
                        ForEach(inactiveProviders) { provider in
                            NavigationLink(value: NavigationDestination.editProvider(provider)) {
                                ProviderListRow(provider: provider)
                                    .transition(.asymmetric(insertion: .scale(scale: 0.9).combined(with: .opacity),
                                                         removal: .scale(scale: 0.9).combined(with: .opacity)))
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal)
                        }
                    }
                    
                    if activeProviders.isEmpty && inactiveProviders.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 48))
                                .foregroundColor(ThemeColors.textSecondary)
                            
                            Text("No Support Network Yet")
                                .font(.headline)
                                .foregroundColor(ThemeColors.textPrimary)
                            
                            Text("Add your first support person to build your network of care and assistance.")
                                .font(.subheadline)
                                .foregroundColor(ThemeColors.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height - 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: animationId)
                .padding(.vertical)
                .padding(.bottom, 100)
            }
        }
        .background(ThemeColors.background)
        .navigationTitle("Supporters")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: NavigationDestination.editProvider(nil)) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct ProviderIconView: View {
    let provider: Provider
    let size: CGFloat
    
    private var initials: String {
        let firstInitial = provider.firstName?.prefix(1).uppercased() ?? ""
        let lastInitial = provider.lastName?.prefix(1).uppercased() ?? ""
        return "\(firstInitial)\(lastInitial)"
    }
    
    private var backgroundColor: Color {
        return Color(hex: "3A3A3A")
    }
    
    private var textColor: Color {
        return .white
    }
    
    var body: some View {
        if let imageData = provider.profileImage, let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(Circle())
        } else {
            ZStack {
                Circle()
                    .fill(backgroundColor)
                Text(initials)
                    .font(.system(size: size * 0.4, weight: .medium))
                    .foregroundColor(textColor)
            }
            .frame(width: size, height: size)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ProviderListRow: View {
    @ObservedObject var provider: Provider
    @State private var showingDeleteConfirmation = false
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isPressed = false
    @State private var animationId = UUID()
    
    var providerType: ProviderType {
        ProviderType(rawValue: provider.type ?? "Therapist") ?? .therapist
    }
    
    var providerTitle: PersonTitle {
        PersonTitle(rawValue: provider.title ?? "none") ?? .none
    }
    
    var displayName: String {
        let title = providerTitle == .none ? "" : "\(providerTitle.displayName) "
        return "\(title)\(provider.firstName ?? "") \(provider.lastName ?? "")"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ProviderIconView(provider: provider, size: 50)
                    .padding(.trailing, 8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(displayName)
                        .font(.headline)
                        .foregroundColor(ThemeColors.textPrimary)
                    
                    Text(providerType.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            
            if let email = provider.email, !email.isEmpty {
                Text(email)
                    .font(.subheadline)
                    .foregroundColor(ThemeColors.textSecondary)
                    .transition(.opacity)
            }
            
            if let phone = provider.phoneNumber, !phone.isEmpty {
                Text(phone)
                    .font(.caption)
                    .foregroundColor(ThemeColors.textSecondary)
                    .transition(.opacity)
            }
            
            if let website = provider.website, !website.isEmpty {
                Text(website)
                    .font(.caption)
                    .foregroundColor(.white)
                    .transition(.opacity)
            }
            
            if let notes = provider.notes, !notes.isEmpty {
                Text(notes)
                    .font(.caption)
                    .foregroundColor(ThemeColors.textSecondary)
                    .padding(.top, 4)
                    .transition(.opacity)
            }
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .alert("Delete Support Member", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                withAnimation {
                    deleteProvider()
                }
            }
        } message: {
            Text("Are you sure you want to delete this support network member? This action cannot be undone.")
        }
    }
    
    private func deleteProvider() {
        viewContext.delete(provider)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting provider: \(error)")
        }
    }
}

struct NewProviderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var provider: Provider?
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var title = PersonTitle.none
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var website = ""
    @State private var isActive = true
    @State private var notes = ""
    @State private var selectedType: ProviderType = .therapist
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var isLoaded = false
    @State private var showingDeleteConfirmation = false
    
    @FetchRequest(
        entity: Session.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: true)]
    ) private var sessions: FetchedResults<Session>
    
    private var isEditing: Bool {
        provider != nil
    }
    
    private var isFormValid: Bool {
        let trimmedFirstName = firstName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedLastName = lastName.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Require at least first name and last name
        return !trimmedFirstName.isEmpty && !trimmedLastName.isEmpty
    }
    
    var body: some View {
        Form {
            // Profile Photo
            VStack {
                HStack {
                    Spacer()
                    if let image = inputImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 40))
                            )
                            .transition(.scale.combined(with: .opacity))
                    }
                    Spacer()
                }
                
                HStack(spacing: 12) {
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text(inputImage == nil ? "Add Photo" : "Change Photo")
                            .foregroundColor(.white)
                    }
                    
                    if inputImage != nil {
                        Button(action: {
                            withAnimation {
                                inputImage = nil
                            }
                        }) {
                            Text("Remove Photo")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .listRowBackground(Color.clear)
            .padding(.vertical, 8)
            .offset(y: isLoaded ? 0 : 20)
            .opacity(isLoaded ? 1 : 0)
            
            Section(header: Text("Basic Information")) {
                Picker("Type", selection: $selectedType) {
                    ForEach(ProviderType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .onChange(of: selectedType) { newType in
                    withAnimation(.spring(response: 0.3)) {
                        // Auto-select title based on provider type
                        switch newType {
                        case .priest:
                            title = .fr
                        case .pastor:
                            title = .pastor
                        case .rabbi:
                            title = .rabbi
                        case .imam:
                            title = .imam
                        case .therapist, .psychologist, .psychiatrist:
                            title = .dr
                        case .professor:
                            title = .prof
                        case .counselor, .socialWorker, .chaplain, .spiritualAdvisor,
                             .lifecoach, .nutritionist, .occupationalTherapist, .physicalTherapist,
                             .nurse, .mentor, .supportGroup, .friend, .family:
                            if [.fr, .pastor, .rabbi, .imam].contains(title) {
                                title = .none
                            }
                        }
                    }
                }
                
                Picker("Title", selection: $title) {
                    ForEach(PersonTitle.allCases, id: \.self) { title in
                        Text(title.displayName).tag(title)
                    }
                }
                
                TextField("First Name", text: $firstName)
                    .textFieldStyle(ModernTextFieldStyle())
                    .textContentType(.givenName)
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(ModernTextFieldStyle())
                    .textContentType(.familyName)
            }
            .offset(y: isLoaded ? 0 : 20)
            .opacity(isLoaded ? 1 : 0)
            
            if selectedType.requiresCredentials {
                Section(header: Text("Contact Information")) {
                    TextField("Email", text: $email)
                        .textFieldStyle(ModernTextFieldStyle())
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                    TextField("Phone Number", text: $phoneNumber)
                        .textFieldStyle(ModernTextFieldStyle())
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                    TextField("Website", text: $website)
                        .textFieldStyle(ModernTextFieldStyle())
                        .textContentType(.URL)
                        .keyboardType(.URL)
                }
            }
            
            Section(header: Text("Status")) {
                Toggle("Currently Active", isOn: $isActive)
            }
            .offset(y: isLoaded ? 0 : 20)
            .opacity(isLoaded ? 1 : 0)
            
            Section(header: Text("Additional Notes")) {
                TextEditor(text: $notes)
                    .frame(minHeight: 100)
            }
            .offset(y: isLoaded ? 0 : 20)
            .opacity(isLoaded ? 1 : 0)
        }
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8).delay(0.1)) {
                isLoaded = true
            }
            if let provider = provider {
                firstName = provider.firstName ?? ""
                lastName = provider.lastName ?? ""
                email = provider.email ?? ""
                phoneNumber = provider.phoneNumber ?? ""
                website = provider.website ?? ""
                isActive = provider.isActive
                notes = provider.notes ?? ""
                selectedType = ProviderType(rawValue: provider.type ?? "Therapist") ?? .therapist
                title = PersonTitle(rawValue: provider.title ?? "none") ?? .none
                if let imageData = provider.profileImage {
                    inputImage = UIImage(data: imageData)
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 100)
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(isEditing ? "Edit Supporter" : "Add Supporter")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { 
                    withAnimation {
                        dismiss()
                    }
                }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
            if isEditing {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveProvider()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        Image("trash")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveProvider()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .keyboardToolbar()
        .alert("Delete Support Member", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let provider = provider {
                    viewContext.delete(provider)
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("Error deleting provider: \(error)")
                    }
                }
            }
        } message: {
            Text("Are you sure you want to delete this support network member? This action cannot be undone.")
        }
    }
    
    private func saveProvider() {
        let oldName = provider != nil ? "\(provider?.firstName ?? "") \(provider?.lastName ?? "")" : ""
        let newName = "\(firstName.trimmingCharacters(in: .whitespaces)) \(lastName.trimmingCharacters(in: .whitespaces))"
        
        let providerToSave = provider ?? Provider(context: viewContext)
        providerToSave.firstName = firstName
        providerToSave.lastName = lastName
        providerToSave.email = email
        providerToSave.phoneNumber = phoneNumber
        providerToSave.website = website
        providerToSave.isActive = isActive
        providerToSave.notes = notes
        providerToSave.type = selectedType.rawValue
        providerToSave.title = title.rawValue
        providerToSave.id = provider?.id ?? UUID()
        
        if let image = inputImage {
            providerToSave.profileImage = image.jpegData(compressionQuality: 0.8)
        } else {
            providerToSave.profileImage = nil
        }
        
        // Update all sessions that reference this provider
        if isEditing && oldName != newName {
            for session in sessions {
                if session.therapist == oldName {
                    session.therapist = newName
                }
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving provider: \(error)")
        }
    }
}

enum NavigationDestination: Hashable {
    case session(Session?)
    case newSession
    case profile
    case allSessions([Session])
    case newTherapist
    case therapistPicker(Binding<String>)
    case thought(Thought?)
    case newThought
    case goal(Treatment?)
    case newGoal
    case selectProvider(Binding<String>)
    case editProvider(Provider?)
    
    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        switch (lhs, rhs) {
        case (.session(let s1), .session(let s2)):
            return s1?.id == s2?.id
        case (.newSession, .newSession):
            return true
        case (.profile, .profile):
            return true
        case (.allSessions(let s1), .allSessions(let s2)):
            return s1 == s2
        case (.newTherapist, .newTherapist):
            return true
        case (.therapistPicker, .therapistPicker):
            return true
        case (.thought(let t1), .thought(let t2)):
            return t1?.id == t2?.id
        case (.newThought, .newThought):
            return true
        case (.goal(let g1), .goal(let g2)):
            return g1?.id == g2?.id
        case (.newGoal, .newGoal):
            return true
        case (.selectProvider(let t1), .selectProvider(let t2)):
            return t1.wrappedValue == t2.wrappedValue
        case (.editProvider(let p1), .editProvider(let p2)):
            return p1?.id == p2?.id
        default:
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .session(let session):
            hasher.combine("session")
            hasher.combine(session?.id)
        case .newSession:
            hasher.combine("newSession")
        case .profile:
            hasher.combine("profile")
        case .allSessions(let sessions):
            hasher.combine("allSessions")
            hasher.combine(sessions)
        case .newTherapist:
            hasher.combine("newTherapist")
        case .therapistPicker:
            hasher.combine("therapistPicker")
        case .thought(let thought):
            hasher.combine("thought")
            hasher.combine(thought?.id)
        case .newThought:
            hasher.combine("newThought")
        case .goal(let goal):
            hasher.combine("goal")
            hasher.combine(goal?.id)
        case .newGoal:
            hasher.combine("newGoal")
        case .selectProvider(let selectedTherapist):
            hasher.combine("selectProvider")
            hasher.combine(selectedTherapist.wrappedValue)
        case .editProvider(let provider):
            hasher.combine("editProvider")
            hasher.combine(provider?.id)
        }
    }
}

struct BottomNavigationBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(tabIndex: 0, imageName: "calendar-lines-pen", textName: "Chats", selectedTab: $selectedTab)
            TabBarButton(tabIndex: 1, imageName: "notes", textName: "Goals", selectedTab: $selectedTab)
            TabBarButton(tabIndex: 2, imageName: "memo", textName: "Thoughts", selectedTab: $selectedTab)
            TabBarButton(tabIndex: 3, imageName: "user", textName: "Supporters", selectedTab: $selectedTab)
            TabBarButton(tabIndex: 4, imageName: "user", textName: "Myself", selectedTab: $selectedTab)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .glassEffect()
        .padding(.horizontal)
    }
}

struct TabBarButton: View {
    let tabIndex: Int
    let imageName: String
    let textName: String
    @Binding var selectedTab: Int
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tabIndex
            }
        }) {
            VStack(spacing: 4) {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(selectedTab == tabIndex ? ThemeColors.navActive : ThemeColors.navInactive)
                    .frame(width: 24, height: 24)
                    .scaleEffect(selectedTab == tabIndex ? 1.2 : 1.0)
                
                if userSettings.showNavLabels {
                    Text(textName)
                        .font(.caption2)
                        .fontWeight(selectedTab == tabIndex ? .medium : .regular)
                        .foregroundColor(selectedTab == tabIndex ? ThemeColors.navActive : ThemeColors.navInactive)
                        .opacity(selectedTab == tabIndex ? 1.0 : 0.7)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    

}

// Helper shape for custom corner rounding
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
        }
    }

//MARK: - App Code
struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var therapistManager: TherapistManager
    
    @FetchRequest(
        entity: Session.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: false)]
    ) var sessions: FetchedResults<Session>
    
    private var upcomingSessions: [Session] {
        sessions.filter { $0.date ?? Date() > Date() }
                .sorted { ($0.date ?? Date()) < ($1.date ?? Date()) }
    }
    
    private var upcomingSessionsCount: Int {
        upcomingSessions.count
    }
    
    private var pastSessions: [Session] {
        sessions.filter { $0.date ?? Date() <= Date() }
                .sorted { ($0.date ?? Date()) > ($1.date ?? Date()) }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 16) {
                    if sessions.isEmpty {
                        // Complete empty state
                        VStack(spacing: 16) {
                            Image(systemName: "calendar.badge.plus")
                                .font(.system(size: 48))
                                .foregroundColor(ThemeColors.textSecondary)
                            
                            Text("No Conversations Yet")
                                .font(.headline)
                                .foregroundColor(ThemeColors.textPrimary)
                            
                            Text("Schedule your first conversation to start your journey with support and growth.")
                                .font(.subheadline)
                                .foregroundColor(ThemeColors.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height - 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        // Upcoming Sessions Section - only show if there are upcoming sessions
                        if !upcomingSessions.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Upcoming Conversations")
                                        .font(.headline)
                                        .foregroundColor(ThemeColors.textPrimary)
                                        .padding(.horizontal)
                                    Spacer()
                                    
                                    NavigationLink(value: NavigationDestination.allSessions(upcomingSessions)) {
                                        HStack(spacing: 4) {
                                            Text("See all")
                                                .font(.subheadline)
                                            Image(systemName: "arrow.right")
                                                .font(.caption)
                                        }
                                        .foregroundColor(ThemeColors.textSecondary)
                                    }
                                }
                                
                                if let nextSession = upcomingSessions.first {
                                    NavigationLink(value: NavigationDestination.session(nextSession)) {
                                        UpcomingEventCard(session: nextSession)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Past Sessions Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Past Conversations")
                                .font(.headline)
                                .foregroundColor(ThemeColors.textPrimary)
                                .padding(.horizontal)
                            
                            if pastSessions.isEmpty {
                                Text("No past conversations yet")
                                    .font(.subheadline)
                                    .foregroundColor(ThemeColors.textSecondary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding()
                            } else {
                                LazyVStack(spacing: 12) {
                                    ForEach(pastSessions, id: \.self) { session in
                                        NavigationLink(value: NavigationDestination.session(session)) {
                                            PastSessionRow(session: session)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                .padding(.bottom, 100)
            }
        }
        .background(ThemeColors.background)
        .navigationTitle("Chats")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: NavigationDestination.newSession) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct StatCard: View {
    let icon: String
    let title: String
    let value: String
    let backgroundColor: Color
    let iconColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 14))
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(ThemeColors.textSecondary)
            }
            
            Text(value)
                .font(.headline)
                .foregroundColor(ThemeColors.textPrimary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(backgroundColor)
        .cornerRadius(16)
    }
}

struct UpcomingEventCard: View {
    @ObservedObject var session: Session
    @FetchRequest(
        entity: Provider.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Provider.lastName, ascending: true)]
    ) private var providers: FetchedResults<Provider>
    
    private var providerType: String {
        guard let therapistName = session.therapist else { return "Support Person" }
        if let provider = providers.first(where: { "\($0.firstName ?? "") \($0.lastName ?? "")" == therapistName }) {
            return ProviderType(rawValue: provider.type ?? "Therapist")?.displayLabel ?? "Support Person"
        }
        return "Support Person"
    }
    
    private var provider: Provider? {
        guard let therapistName = session.therapist else { return nil }
        return providers.first(where: { "\($0.firstName ?? "") \($0.lastName ?? "")" == therapistName })
    }
    
    private func formatSessionDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(formatSessionDate(session.date ?? Date())), \(formatTime(session.date ?? Date())) - \(formatEndTime(session.date ?? Date()))")
                .font(.caption)
                .foregroundColor(ThemeColors.textSecondary)
            
            Text(session.title ?? "Session")
                .font(.headline)
                .foregroundColor(ThemeColors.textPrimary)
            
            if let therapist = session.therapist {
                HStack(spacing: 10) {
                    if let provider = provider {
                        ProviderIconView(provider: provider, size: 40)
                    } else {
                        Circle()
                            .fill(ThemeColors.cardBackground)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(String(therapist.prefix(1)))
                                    .foregroundColor(ThemeColors.textPrimary)
                                    .font(.system(size: 18, weight: .medium))
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(therapist)
                            .font(.subheadline)
                            .foregroundColor(ThemeColors.textPrimary)
                        Text(providerType)
                            .font(.caption)
                            .foregroundColor(ThemeColors.textSecondary)
                    }
                }
            }
            
            if let purpose = session.purpose, !purpose.isEmpty {
                Text("Session with \(session.therapist ?? "a support person") to discuss \(purpose)")
                    .font(.subheadline)
                    .foregroundColor(ThemeColors.textSecondary)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeColors.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(ThemeColors.border, lineWidth: 1)
        )
    }
    
    // Format end time by adding 1 hour to the session time
    private func formatEndTime(_ date: Date) -> String {
        let endTime = Calendar.current.date(byAdding: .hour, value: 1, to: date) ?? date
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: endTime)
    }
}

struct PastSessionRow: View {
    @ObservedObject var session: Session
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(session.title ?? "Therapy Session")
                .font(.headline)
                .foregroundColor(ThemeColors.textPrimary)
            
            Text("Session with \(session.therapist ?? "a therapist") to discuss \(session.purpose ?? "nothing specific.")")
                .font(.subheadline)
                .foregroundColor(ThemeColors.textSecondary)
            
            Text(formatDate(session.date ?? Date()))
                .font(.caption)
                .foregroundColor(ThemeColors.textSecondary)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeColors.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(ThemeColors.border, lineWidth: 1)
        )
    }
}

//MARK: - Profile View
struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var themeManager: ThemeManager

    @State private var showingDisorderDetail = false
    @State private var showingDisordersList = false
    @State private var selectedDisorder: Disorder?
    @State private var isCloudKitAvailable = FileManager.default.ubiquityIdentityToken != nil

    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: []
    ) var client: FetchedResults<Client>

    @FetchRequest(
        entity: Disorder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Disorder.name, ascending: true)]
    ) var disorders: FetchedResults<Disorder>
    
    @FetchRequest(
        entity: Session.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: false)]
    ) var sessions: FetchedResults<Session>
    
    @FetchRequest(
        entity: Treatment.entity(),
        sortDescriptors: []
    ) var treatments: FetchedResults<Treatment>
    
    @FetchRequest(
        entity: Thought.entity(),
        sortDescriptors: []
    ) var thoughts: FetchedResults<Thought>
    
    @FetchRequest(
        entity: Provider.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isActive = YES")
    ) var activeProviders: FetchedResults<Provider>

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Sync Status Indicator
                if isCloudKitAvailable {
                    HStack {
                        Image(systemName: "checkmark.icloud")
                            .foregroundColor(ThemeColors.accent4)
                        
                        Text("iCloud Sync Enabled")
                            .font(.caption)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(ThemeColors.cardBackground.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                } else {
                    HStack {
                        Image(systemName: "internaldrive")
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        Text("Local Storage Only")
                            .font(.caption)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(ThemeColors.cardBackground.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                // Profile Header
                VStack(spacing: 16) {
                    
                    // Statistics Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 12) {
                        StatCard(icon: "calendar", title: "Chats", value: "\(sessions.count)", backgroundColor: Color.white.opacity(0.1), iconColor: .white)
                        StatCard(icon: "target", title: "Goals", value: "\(treatments.count)", backgroundColor: ThemeColors.accent2.opacity(0.1), iconColor: ThemeColors.accent2)
                        StatCard(icon: "brain.head.profile", title: "Thoughts", value: "\(thoughts.count)", backgroundColor: ThemeColors.accent3.opacity(0.1), iconColor: ThemeColors.accent3)
                        StatCard(icon: "person.2", title: "Support People", value: "\(activeProviders.count)", backgroundColor: ThemeColors.accent4.opacity(0.1), iconColor: ThemeColors.accent4)
                    }
                    
                    if let lastSession = sessions.first {
                        VStack(spacing: 8) {
                            Text("Last Session")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(ThemeColors.textSecondary)
                            
                            Text(formatLastSessionDate(lastSession.date))
                                .font(.subheadline)
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(ThemeColors.cardBackground)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(ThemeColors.border, lineWidth: 1)
                        )
                    }
                }
                .padding()
                .background(ThemeColors.cardBackground)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(ThemeColors.border, lineWidth: 1)
                )
                .padding(.horizontal)
                
                // Diagnoses
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Diagnoses")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(ThemeColors.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            showingDisordersList = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(8)
                                .glassEffect()
                        }
                    }
                    
                    Divider()
                        .background(ThemeColors.border)
                    
                    ForEach(client.first?.disordersArray ?? [], id: \.self) { disorder in
                        DisclosureGroup {
                            Text(disorder.desc ?? "No description available")
                                .font(.subheadline)
                                .foregroundColor(ThemeColors.textSecondary)
                                .padding(.vertical, 8)
                        } label: {
                            Text(disorder.name ?? "Unknown")
                                .font(.headline)
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                        .accentColor(.white)
                    }
                }
                .padding()
                .background(ThemeColors.cardBackground)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(ThemeColors.border, lineWidth: 1)
                )
                .padding(.horizontal)
            }
            .padding(.vertical)
            .padding(.bottom, 100)
            .background(ThemeColors.background)
            .navigationTitle("My Information")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(themeManager: themeManager)) {
                        Image("gear")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .sheet(isPresented: $showingDisordersList) {
            if let client = client.first {
                DisordersListView(client: client, viewContext: viewContext)
            }
        }
    }
    
    // MARK: - Helper Functions
    private func formatLastSessionDate(_ date: Date?) -> String {
        guard let date = date else { return "No sessions yet" }
        
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}


struct DisorderItem {
    var name: String
    var desc: String // Ensure this matches what you use when initializing
}

struct DisordersListView: View {
    @ObservedObject var client: Client
    var viewContext: NSManagedObjectContext
    @Environment(\.dismiss) private var dismiss
    
    // Define your static list of disorders here
    let disorders: [DisorderItem] = [
        DisorderItem(name: "Acute Stress Disorder", desc: "A condition characterized by the development of severe anxiety, dissociation, and other symptoms that occur within one month after exposure to an extreme traumatic stressor."),
        DisorderItem(name: "Adjustment Disorders", desc: "Emotional or behavioral symptoms in response to a stressful event or situation, causing significant distress and impairment in social, occupational, or other important areas of functioning."),
        DisorderItem(name: "Agoraphobia", desc: "An anxiety disorder characterized by fear and avoidance of places or situations that might cause panic, helplessness, or embarrassment."),
        DisorderItem(name: "Alcohol Addiction", desc: "A chronic disease characterized by uncontrolled drinking and preoccupation with alcohol."),
        DisorderItem(name: "Anorexia Nervosa", desc: "An eating disorder characterized by an abnormally low body weight, an intense fear of gaining weight, and a distorted perception of body weight."),
        DisorderItem(name: "Antisocial Personality Disorder", desc: "A mental condition in which a person consistently shows no regard for right and wrong and ignores the rights and feelings of others."),
        DisorderItem(name: "Anxiety", desc: "A feeling of worry, nervousness, or unease about something with an uncertain outcome."),
        DisorderItem(name: "Attention-Deficit/Hyperactivity Disorder", desc: "A disorder characterized by a continuous pattern of inattention and/or hyperactivity-impulsivity that interferes with functioning or development."),
        DisorderItem(name: "Autism Spectrum Disorder", desc: "A developmental disorder that affects communication and behavior."),
        DisorderItem(name: "Avoidant Personality Disorder", desc: "A pattern of extreme shyness, feelings of inadequacy, and extreme sensitivity to criticism."),
        DisorderItem(name: "Binge Eating Disorder", desc: "A serious eating disorder in which you frequently consume unusually large amounts of food and feel unable to stop eating."),
        DisorderItem(name: "Bipolar Disorder", desc: "A disorder associated with episodes of mood swings ranging from depressive lows to manic highs."),
        DisorderItem(name: "Body Dysmorphic Disorder", desc: "A mental illness involving obsessive focus on a perceived flaw in appearance."),
        DisorderItem(name: "Body-Focused Repetitive Behavior Disorders", desc: "A group of related disorders characterized by repetitive, body-focused behaviors and the inability to stop engaging in them despite attempts to do so."),
        DisorderItem(name: "Borderline Personality Disorder", desc: "A mental health disorder characterized by pervasive instability in moods, interpersonal relationships, self-image, and behavior."),
        DisorderItem(name: "Bulimia Nervosa", desc: "An eating disorder characterized by binge eating followed by purging."),
        DisorderItem(name: "Burnout", desc: "A state of emotional, physical, and mental exhaustion caused by prolonged and excessive stress, often related to work or caregiving responsibilities."),
        DisorderItem(name: "Cannabis Addiction", desc: "A condition characterized by the compulsive use of cannabis despite negative consequences."),
        DisorderItem(name: "Conduct Disorder", desc: "A range of antisocial types of behavior displayed in childhood or adolescence."),
        DisorderItem(name: "Conversion Disorder", desc: "A mental condition in which a person has blindness, paralysis, or other nervous system (neurologic) symptoms that cannot be explained by medical evaluation."),
        DisorderItem(name: "Cyclothymic Disorder", desc: "A disorder that causes emotional ups and downs that are less extreme than bipolar disorder."),
        DisorderItem(name: "Delusional Disorder", desc: "A mental disorder characterized by the presence of one or more delusions that last for a month or longer without the significant hallucinations characteristic of schizophrenia."),
        DisorderItem(name: "Dependent Personality Disorder", desc: "A psychiatric condition marked by an overreliance on others to meet their emotional and physical needs."),
        DisorderItem(name: "Depersonalization/Derealization Disorder", desc: "A disorder marked by periods of feeling disconnected or detached from one's body and thoughts (depersonalization) or from one's surroundings (derealization)."),
        DisorderItem(name: "Depression", desc: "A mood disorder that causes a persistent feeling of sadness and loss of interest."),
        DisorderItem(name: "Disordered Gambling", desc: "A behavioral addiction characterized by persistent and recurrent problematic gambling behavior leading to clinically significant impairment or distress."),
        DisorderItem(name: "Disruptive Mood Dysregulation Disorder", desc: "A childhood condition of extreme irritability, anger, and frequent, intense temper outbursts."),
        DisorderItem(name: "Dissociative Amnesia", desc: "A disorder characterized by an inability to recall important personal information, usually of a traumatic or stressful nature."),
        DisorderItem(name: "Dissociative Disorders", desc: "Disorders that involve experiencing a disconnection and lack of continuity between thoughts, memories, surroundings, actions, and identity."),
        DisorderItem(name: "Dissociative Identity Disorder", desc: "A severe form of dissociation, a mental process which produces a lack of connection in a person's thoughts, memory, and sense of identity."),
        DisorderItem(name: "Eating Disorders", desc: "Disorders characterized by abnormal or disturbed eating habits, such as anorexia nervosa or bulimia nervosa."),
        DisorderItem(name: "Excoriation Disorder", desc: "A disorder characterized by the recurrent compulsion to pick at one's own skin, sometimes to the extent of causing damage."),
        DisorderItem(name: "Factitious Disorder", desc: "A condition wherein individuals deceive others by appearing sick, purposely getting sick, or self-injuring without obvious benefits like financial gain."),
        DisorderItem(name: "Generalized Anxiety Disorder", desc: "An anxiety disorder characterized by chronic anxiety, exaggerated worry, and tension, even when there is little or nothing to provoke it."),
        DisorderItem(name: "Gender Dysphoria", desc: "A conflict between a person's physical or assigned gender and the gender with which they identify, often leading to significant distress."),
        DisorderItem(name: "Hoarding Disorder", desc: "A disorder characterized by the persistent difficulty discarding or parting with possessions, regardless of their actual value."),
        DisorderItem(name: "Histrionic Personality Disorder", desc: "A personality disorder characterized by a pattern of excessive attention-seeking emotions, usually beginning in early adulthood, including inappropriately seductive behavior and an excessive need for approval."),
        DisorderItem(name: "Illness Anxiety Disorder", desc: "A disorder characterized by excessive worry that you are or may become seriously ill, despite few or no symptoms and negative medical evaluations."),
        DisorderItem(name: "Impulse Control Disorders", desc: "Disorders characterized by an inability to resist urges to perform acts that could be harmful, such as Pyromania (deliberate fire-setting) or Pathological Gambling."),
        DisorderItem(name: "Inhalant Addiction", desc: "The use of household and industrial chemicals for their psychoactive effects, often leading to a range of health problems and dependence."),
        DisorderItem(name: "Insomnia Disorder", desc: "A common sleep disorder that can make it hard to fall asleep, hard to stay asleep, or cause you to wake up too early and not be able to get back to sleep."),
        DisorderItem(name: "Intermittent Explosive Disorder", desc: "A disorder characterized by repeated, sudden episodes of impulsive, aggressive, violent behavior or angry verbal outbursts in which you react grossly out of proportion to the situation."),
        DisorderItem(name: "Internet Gaming Disorder", desc: "A condition characterized by persistent and recurrent participation in digital or video gaming, typically to the extent that it takes precedence over other interests and daily activities."),
        DisorderItem(name: "Kleptomania", desc: "A failure to resist urges to steal items that you generally don't really need and that usually have little value."),
        DisorderItem(name: "Major Depressive Disorder", desc: "A mood disorder causing a persistent feeling of sadness and loss of interest."),
        DisorderItem(name: "Mania", desc: "A state of abnormally elevated arousal, affect, and energy level, or a state of heightened overall activation with enhanced affective expression together with lability of affect."),
        DisorderItem(name: "Misophonia", desc: "A disorder characterized by intense emotional and physiological reactions to specific sounds, often leading to avoidance behaviors and significant distress."),
        DisorderItem(name: "Narcissistic Personality Disorder", desc: "A disorder in which a person has an inflated sense of self-importance and an extreme preoccupation with themselves."),
        DisorderItem(name: "Neurocognitive Disorders", desc: "A category of mental health diagnoses that includes cognitive decline associated with Alzheimer's Disease, Vascular Neurocognitive Disorder, and Lewy Body Dementia."),
        DisorderItem(name: "Non-Suicidal Self-Injury Disorder", desc: "A condition where someone deliberately harms themselves without suicidal intent, often to cope with emotional pain, anger, or other intense negative feelings."),
        DisorderItem(name: "Obsessive-Compulsive Disorder", desc: "A disorder characterized by uncontrollable, reoccurring thoughts (obsessions) and behaviors (compulsions) that he or she feels the urge to repeat over and over."),
        DisorderItem(name: "Oppositional Defiant Disorder", desc: "A disorder in children marked by defiant and disobedient behavior to authority figures."),
        DisorderItem(name: "Panic Disorder", desc: "An anxiety disorder characterized by recurrent unexpected panic attacks."),
        DisorderItem(name: "Paranoid Personality Disorder", desc: "A pattern of distrust and suspiciousness such that others' motives are interpreted as malevolent."),
        DisorderItem(name: "Persistent Depressive Disorder", desc: "A continuous long-term (chronic) form of depression lasting for at least two years in adults or one year in children."),
        DisorderItem(name: "Pica", desc: "A compulsive eating disorder in which people eat nonfood items."),
        DisorderItem(name: "Post-Traumatic Stress Disorder", desc: "A disorder characterized by failure to recover after experiencing or witnessing a terrifying event."),
        DisorderItem(name: "Premenstrual Dysphoric Disorder", desc: "A severe form of premenstrual syndrome involving severe physical and behavioral symptoms that resolve with the onset of menstruation."),
        DisorderItem(name: "Pyromania", desc: "An impulse control disorder in which individuals repeatedly fail to resist impulses to deliberately start fires, in order to relieve tension or for instant gratification."),
        DisorderItem(name: "Reactive Attachment Disorder", desc: "A disorder in which a child fails to form healthy emotional bonds with their primary caregivers, often as a result of severe early neglect or abuse."),
        DisorderItem(name: "Rumination Disorder", desc: "A condition in which a person repeatedly and persistently regurgitates food after eating."),
        DisorderItem(name: "Schizoaffective Disorder", desc: "A mental health disorder characterized by a combination of schizophrenia symptoms, such as hallucinations or delusions, and mood disorder symptoms, like depression or mania."),
        DisorderItem(name: "Schizoid Personality Disorder", desc: "A condition characterized by a long-standing pattern of detachment from social relationships and a limited range of expression of emotions in interpersonal settings."),
        DisorderItem(name: "Schizophrenia", desc: "A disorder that affects a person's ability to think, feel, and behave clearly."),
        DisorderItem(name: "Schizotypal Personality Disorder", desc: "A pattern of acute discomfort in close relationships, cognitive or perceptual distortions, and eccentricities of behavior."),
        DisorderItem(name: "Seasonal Affective Disorder", desc: "A type of depression that's related to changes in seasons, typically starting in the late fall and early winter and going away during the spring and summer."),
        DisorderItem(name: "Selective Mutism", desc: "An anxiety disorder where a child is unable to speak in certain social situations, such as school, despite speaking in other situations."),
        DisorderItem(name: "Separation Anxiety Disorder", desc: "A childhood disorder characterized by excessive anxiety for the child's developmental level and related to separation from parents or others who have parental roles."),
        DisorderItem(name: "Sex Addiction", desc: "A state characterized by compulsive participation or engagement in sexual activity, particularly sexual intercourse, despite negative consequences."),
        DisorderItem(name: "Sexual Dysfunctions", desc: "Includes disorders such as Erectile Dysfunction, Premature Ejaculation, Female Sexual Interest/Arousal Disorder, and Genito-Pelvic Pain/Penetration Disorder that significantly affect sexual health and experience."),
        DisorderItem(name: "Sleep-Wake Disorders", desc: "Includes disorders like Narcolepsy, Sleep Apnea, Restless Legs Syndrome, and Circadian Rhythm Sleep-Wake Disorders, affecting the quality, timing, and amount of sleep."),
        DisorderItem(name: "Social Anxiety Disorder", desc: "A chronic condition that causes an irrational anxiety or fear of being judged or humiliated in social situations."),
        DisorderItem(name: "Somatic Symptom Disorder", desc: "A disorder in which a person feels extreme anxiety about physical symptoms such as pain or fatigue. The individual has intense thoughts, feelings, and behaviors related to the symptoms, which interfere with daily life."),
        DisorderItem(name: "Specific Phobias", desc: "A significant and persistent fear of a specific object or situation that is generally considered harmless."),
        DisorderItem(name: "Stimulant Addiction", desc: "A condition characterized by dependence on substances that stimulate the nervous system, such as cocaine, amphetamines, and methamphetamines."),
        DisorderItem(name: "Substance Use Disorders", desc: "The recurrent use of alcohol and/or drugs causes clinically and functionally significant impairment, such as health problems, disability, and failure to meet major responsibilities at work, school, or home."),
        DisorderItem(name: "Tobacco Addiction", desc: "A condition marked by a dependence on nicotine, which is found in tobacco products."),
        DisorderItem(name: "Trichotillomania", desc: "A disorder characterized by an irresistible urge to pull out hair from your scalp, eyebrows or other areas of your body, despite trying to stop.")
    ]


    // Remove the disorders parameter from the initializer since it's not needed
    init(client: Client, viewContext: NSManagedObjectContext) {
        self.client = client
        self.viewContext = viewContext
        // No need to initialize disorders here since it's a static list
    }

    var disorderSections: [String] {
        groupedDisorders.keys.sorted()
    }
    
    private var groupedDisorders: [String: [DisorderItem]] {
        Dictionary(grouping: disorders) { String($0.name.prefix(1)).uppercased() }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(groupedDisorders.keys.sorted(), id: \.self) { sectionKey in
                    Section(header: Text(sectionKey)
                        .foregroundColor(ThemeColors.textSecondary)
                        .glassEffect()) {
                        ForEach(groupedDisorders[sectionKey] ?? [], id: \.name) { disorder in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(disorder.name)
                                        .bold()
                                        .foregroundColor(ThemeColors.textPrimary)
                                    Text(disorder.desc)
                                        .font(.caption)
                                        .foregroundColor(ThemeColors.textSecondary)
                                }
                                Spacer()
                                Group {
                                    if clientHasDisorder(disorder) {
                                        Image("check")
                                            .resizable()
                                            .renderingMode(.template)
                                            .frame(width: 14, height: 14)
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: "plus")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .glassEffect()
                                    }
                                }
                                    .onTapGesture {
                                        if clientHasDisorder(disorder) {
                                            removeDisorderFromClient(disorder)
                                        } else {
                                            addDisorderToClient(disorder)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .background(ThemeColors.background)
            .navigationTitle("Add Diagnosis")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image("arrow-down")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .background(ThemeColors.background)
        .preferredColorScheme(.dark)
    }

    func clientHasDisorder(_ disorderItem: DisorderItem) -> Bool {
        client.disordersArray.contains { $0.name == disorderItem.name }
    }

    private func addDisorderToClient(_ disorderItem: DisorderItem) {
        let newDisorder = Disorder(context: viewContext)
        newDisorder.name = disorderItem.name
        newDisorder.desc = disorderItem.desc
        client.addToDisorders(newDisorder)
        saveContext()
    }

    private func removeDisorderFromClient(_ disorderItem: DisorderItem) {
        guard let disorderToRemove = client.disordersArray.first(where: { $0.name == disorderItem.name }) else { return }
        client.removeFromDisorders(disorderToRemove)
        viewContext.delete(disorderToRemove)
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
            print("Changes saved to context successfully")
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}


//MARK: - Session View
struct SessionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var isLoaded = false
    @State private var showingDeleteConfirmation = false
    @State private var currentSession: Session?
    @State private var hasInitializedData = false
    
    var session: Session?
    
    @State private var title: String = ""
    @State private var advice: String = ""
    @State private var date: Date = Date()
    @State private var therapist: String = ""
    @State private var purpose: String = ""
    @State private var notes: String = ""
    @State private var navigationPath = NavigationPath()
    
    @FetchRequest(
        entity: Provider.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Provider.lastName, ascending: true),
            NSSortDescriptor(keyPath: \Provider.firstName, ascending: true)
        ],
        predicate: NSPredicate(format: "isActive = YES")
    ) private var activeProviders: FetchedResults<Provider>
    
    @FetchRequest(
        entity: Session.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: true)]
    ) private var sessions: FetchedResults<Session>
    
    @FocusState private var focusedField: Field?
    
    private enum Field: Hashable {
        case therapist, title, purpose, advice, notes
    }
    
    init(session: Session?) {
        self.session = session
        // We don't need to initialize state variables here anymore
        // They will be set in onAppear
    }
    
    private var sessionCount: Int {
        sessions.count
    }
    
    private var isFormValid: Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedTherapist = therapist.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Require at least title and therapist
        return !trimmedTitle.isEmpty && !trimmedTherapist.isEmpty
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Support Person
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SUPPORT PERSON")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        NavigationLink(value: NavigationDestination.selectProvider($therapist)) {
                            HStack {
                                Text(therapist.isEmpty ? "Select Support Person" : therapist)
                                    .foregroundColor(therapist.isEmpty ? ThemeColors.textSecondary : ThemeColors.textPrimary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(ThemeColors.textSecondary)
                            }
                            .padding()
                            .background(ThemeColors.cardBackground)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(ThemeColors.border, lineWidth: 1)
                            )
                        }
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
                    
                    // Session Title
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SESSION TITLE")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        TextField("Title", text: $title)
                            .textFieldStyle(ModernTextFieldStyle())
                            .focused($focusedField, equals: .title)
                            .foregroundColor(ThemeColors.textPrimary)
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
                    
                    // Date
                    VStack(alignment: .leading, spacing: 8) {
                        Text("APPOINTMENT DATE")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                            .labelsHidden()
                            .accentColor(.white)
                            .foregroundColor(ThemeColors.textPrimary)
                            .tint(.white)
                            .environment(\.colorScheme, .dark)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
                    
                    // Purpose
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SESSION PURPOSE")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        TextField("Purpose of your session...", text: $purpose, axis: .vertical)
                            .textFieldStyle(ModernTextFieldStyle())
                            .focused($focusedField, equals: .purpose)
                            .foregroundColor(ThemeColors.textPrimary)
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
                    
                    Divider()
                        .background(ThemeColors.border)
                        .opacity(isLoaded ? 1 : 0)
                        .padding(.horizontal)
                    
                    // Advice
                    VStack(alignment: .leading, spacing: 8) {
                        Text("SUPPORT PERSON ADVICE")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        TextField("Support person's advice...", text: $advice, axis: .vertical)
                            .textFieldStyle(ModernTextFieldStyle())
                            .focused($focusedField, equals: .advice)
                            .foregroundColor(ThemeColors.textPrimary)
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
                    
                    Divider()
                        .background(ThemeColors.border)
                        .opacity(isLoaded ? 1 : 0)
                        .padding(.horizontal)
                    
                    // Notes
                    VStack(alignment: .leading, spacing: 8) {
                        Text("NOTES")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        TextField("Session notes...", text: $notes, axis: .vertical)
                            .textFieldStyle(ModernTextFieldStyle())
                            .focused($focusedField, equals: .notes)
                            .foregroundColor(ThemeColors.textPrimary)
                    }
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
                }
                .padding(.bottom, 100)
                //.padding(.top)
            }
        }
        //.background(ThemeColors.background)
        .navigationTitle("Session")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if session != nil {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveOrUpdateSession()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        Image("trash")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveOrUpdateSession()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .keyboardToolbar()
        .alert("Delete Session", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let session = session {
                    viewContext.delete(session)
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("Error deleting session: \(error)")
                    }
                }
            }
        } message: {
            Text("Are you sure you want to delete this session? This action cannot be undone.")
        }
        .onAppear {
            currentSession = session
            // Only load data from existing session if we haven't initialized it yet
            if let existingSession = session, !hasInitializedData {
                title = existingSession.title ?? ""
                advice = existingSession.advice ?? ""
                date = existingSession.date ?? Date()
                therapist = existingSession.therapist ?? ""
                purpose = existingSession.purpose ?? ""
                notes = existingSession.notes ?? ""
                hasInitializedData = true
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                isLoaded = true
            }
        }
    }
    
    private func saveOrUpdateSession() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPurpose = purpose.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // If required fields are empty, delete the session if it exists
        if trimmedTitle.isEmpty && trimmedPurpose.isEmpty && therapist.isEmpty {
            if let existingSession = currentSession {
                viewContext.delete(existingSession)
                currentSession = nil
                do {
                    try viewContext.save()
                } catch {
                    print("Error deleting empty session: \(error)")
                }
            }
            return
        }
        
        // Create a new session only if we don't have one yet
        if currentSession == nil {
            currentSession = Session(context: viewContext)
            currentSession?.id = UUID()
            currentSession?.count = Double(sessionCount + 1)
        }
        
        // Update the session
        if let sessionToUpdate = currentSession {
            sessionToUpdate.title = trimmedTitle
            sessionToUpdate.advice = advice
            sessionToUpdate.date = date
            sessionToUpdate.therapist = therapist
            sessionToUpdate.purpose = trimmedPurpose
            sessionToUpdate.notes = notes
            
            do {
                try viewContext.save()
            } catch {
                print("Error saving session: \(error)")
                // If save fails and this was a new session, delete it to prevent corruption
                if session == nil && currentSession != nil {
                    viewContext.delete(sessionToUpdate)
                    currentSession = nil
                }
            }
        }
    }
}

struct ProviderSelectionView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var selectedTherapist: String
    
    @FetchRequest(
        entity: Provider.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Provider.lastName, ascending: true),
            NSSortDescriptor(keyPath: \Provider.firstName, ascending: true)
        ],
        predicate: NSPredicate(format: "isActive = YES")
    ) private var activeProviders: FetchedResults<Provider>
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Support People List
                if !activeProviders.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(activeProviders) { provider in
                            ProviderSelectRow(
                                provider: provider,
                                isSelected: isProviderSelected(provider),
                                action: { selectProvider(provider) }
                            )
                        }
                    }
                } else {
                    VStack(spacing: 12) {
                        Image(systemName: "person.2.slash")
                            .font(.system(size: 40))
                            .foregroundColor(ThemeColors.textSecondary)
                        
                        Text("No Support People")
                            .font(.headline)
                            .foregroundColor(ThemeColors.textPrimary)
                        
                        Text("Go to the Supporters tab to add support people")
                            .font(.subheadline)
                            .foregroundColor(ThemeColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 40)
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical)
            .padding(.bottom, 100)
        }
        .padding(.horizontal)
        .background(ThemeColors.background)
        .navigationTitle("Select Support Person")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
    
    private func isProviderSelected(_ provider: Provider) -> Bool {
        let providerName = "\(provider.firstName ?? "") \(provider.lastName ?? "")"
        return selectedTherapist == providerName
    }
    
    private func selectProvider(_ provider: Provider) {
        selectedTherapist = "\(provider.firstName ?? "") \(provider.lastName ?? "")"
        dismiss()
    }
}


struct ProviderSelectRow: View {
    let provider: Provider
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                ProviderIconView(provider: provider, size: 50)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(provider.firstName ?? "") \(provider.lastName ?? "")")
                        .font(.headline)
                        .foregroundColor(ThemeColors.textPrimary)
                    
                    if let type = provider.type {
                        Text(ProviderType(rawValue: type)?.displayLabel ?? type)
                            .font(.subheadline)
                            .foregroundColor(ThemeColors.textSecondary)
                    }
                    
                    if let email = provider.email, !email.isEmpty {
                        Text(email)
                            .font(.caption)
                            .foregroundColor(ThemeColors.textSecondary)
                    }
                }
                
                Spacer()
                
                if isSelected {
                    Image("check")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                } else {
                    Image(systemName: "circle")
                        .foregroundColor(ThemeColors.textSecondary)
                        .font(.title2)
                }
            }
            .padding()
            .background(isSelected ? Color.white.opacity(0.1) : ThemeColors.cardBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? .white : ThemeColors.border, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ProviderPickerRow: View {
    let provider: Provider
    
    var body: some View {
        HStack {
            ProviderIconView(provider: provider, size: 40)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(provider.firstName ?? "") \(provider.lastName ?? "")")
                    .font(.body)
                    .foregroundColor(ThemeColors.textPrimary)
                
                if let type = provider.type {
                    Text(type)
                        .font(.caption)
                        .foregroundColor(ThemeColors.textSecondary)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

struct TherapistPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var therapistManager: TherapistManager
    @Binding var selectedTherapist: String
    @State private var navigationPath = NavigationPath()
    @State private var showingEditTherapist = false
    @State private var therapistToEdit: Therapist?
    
    var body: some View {
        List {
            Section(header: Text("Active Support People")) {
                ForEach(therapistManager.therapists.filter { $0.isActive }) { therapist in
                    ProviderRow(therapist: therapist, selectedTherapist: $selectedTherapist, dismiss: dismiss)
                }
            }
            
            Section(header: Text("Inactive Support People")) {
                ForEach(therapistManager.therapists.filter { !$0.isActive }) { therapist in
                    ProviderRow(therapist: therapist, selectedTherapist: $selectedTherapist, dismiss: dismiss)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Select Support Person")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    navigationPath.append(NavigationDestination.newTherapist)
                }) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .navigationDestination(for: NavigationDestination.self) { destination in
            if case .newTherapist = destination {
                NewTherapistView()
            }
        }
        .sheet(item: $therapistToEdit) { therapist in
            NewTherapistView(therapistToEdit: therapist)
        }
    }
}

struct ProviderRow: View {
    let therapist: Therapist
    @Binding var selectedTherapist: String
    let dismiss: DismissAction
    @State private var showingOptions = false
    @EnvironmentObject private var therapistManager: TherapistManager
    @State private var showingEditSheet = false
    
    var body: some View {
        Button(action: {
            selectedTherapist = therapist.fullName
            dismiss()
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(therapist.fullName)
                        .font(.headline)
                        .foregroundColor(ThemeColors.textPrimary)
                    
                    if !therapist.email.isEmpty {
                        Text(therapist.email)
                            .font(.subheadline)
                            .foregroundColor(ThemeColors.textSecondary)
                    }
                    
                    if !therapist.phoneNumber.isEmpty {
                        Text(therapist.phoneNumber)
                            .font(.caption)
                            .foregroundColor(ThemeColors.textSecondary)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    showingOptions = true
                }) {
                    Image(systemName: "ellipsis.circle.fill")
                        .foregroundColor(.white)
                }
            }
        }
        .contextMenu {
            Button(action: {
                showingEditSheet = true
            }) {
                Label("Edit", systemImage: "pencil")
            }
            
            Button(role: .destructive, action: {
                therapistManager.removeTherapist(therapist)
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
        .sheet(isPresented: $showingEditSheet) {
            NewTherapistView(therapistToEdit: therapist)
        }
    }
}

struct NewTherapistView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var therapistManager: TherapistManager
    
    var therapistToEdit: Therapist?
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var website = ""
    @State private var isActive = true
    @State private var notes = ""
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("First Name", text: $firstName)
                    .textFieldStyle(ModernTextFieldStyle())
                    .textContentType(.givenName)
                TextField("Last Name", text: $lastName)
                    .textFieldStyle(ModernTextFieldStyle())
                    .textContentType(.familyName)
            }
            
            Section(header: Text("Contact Information")) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                TextField("Phone Number", text: $phoneNumber)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.phonePad)
                TextField("Website", text: $website)
                    .textContentType(.URL)
                    .keyboardType(.URL)
            }
            
            Section(header: Text("Status")) {
                Toggle("Active Provider", isOn: $isActive)
            }
            
            Section(header: Text("Additional Notes")) {
                TextEditor(text: $notes)
                    .frame(minHeight: 100)
            }
        }
        .navigationTitle(therapistToEdit == nil ? "New Support Person" : "Edit Support Person")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    let updatedTherapist = Therapist(
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        phoneNumber: phoneNumber,
                        website: website,
                        isActive: isActive,
                        notes: notes
                    )
                    
                    if therapistToEdit != nil {
                        therapistManager.updateTherapist(updatedTherapist)
                    } else {
                        therapistManager.addTherapist(updatedTherapist)
                    }
                    dismiss()
                }) {
                    Image("check")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                }
                .disabled(firstName.isEmpty || lastName.isEmpty)
            }
        }
        .onAppear {
            if let therapist = therapistToEdit {
                firstName = therapist.firstName
                lastName = therapist.lastName
                email = therapist.email
                phoneNumber = therapist.phoneNumber
                website = therapist.website
                isActive = therapist.isActive
                notes = therapist.notes
            }
        }
    }
}

struct ModernTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(ThemeColors.cardBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(ThemeColors.border, lineWidth: 1)
            )
    }
}

// MARK: - Treatment View
struct TreatmentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var animationId = UUID()
    
    @FetchRequest(
        entity: Treatment.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Treatment.diagnosis, ascending: true)],
        animation: .spring(response: 0.3))
    private var treatment: FetchedResults<Treatment>
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 16) {
                    if treatment.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "target")
                                .font(.system(size: 48))
                                .foregroundColor(ThemeColors.textSecondary)
                            
                            Text("No Goals Yet")
                                .font(.headline)
                                .foregroundColor(ThemeColors.textPrimary)
                            
                            Text("Add your first goal to get started on your personal growth journey.")
                                .font(.subheadline)
                                .foregroundColor(ThemeColors.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height - 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                    ForEach(treatment) { goal in
                        NavigationLink(value: NavigationDestination.goal(goal)) {
                            GoalRow(goal: goal)
                                .id(goal.id)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .transition(.asymmetric(
                            insertion: .scale(scale: 0.9).combined(with: .opacity),
                            removal: .scale(scale: 0.9).combined(with: .opacity)
                        ))
                    }
                }
                }
                .padding(.horizontal)
                .padding(.vertical)
                .padding(.bottom, 100)
            }
        }
        .background(ThemeColors.background)
        .navigationTitle("Goals")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: NavigationDestination.newGoal) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct GoalRow: View {
    @ObservedObject var goal: Treatment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(goal.diagnosis ?? "Unknown Diagnosis")
                .font(.subheadline)
                .foregroundColor(.white)
                .italic()
            
            Text(goal.goal ?? "Unknown Goal")
                .font(.headline)
                .foregroundColor(ThemeColors.textPrimary)
            
            Text(goal.desc ?? "Unknown Description")
                .font(.subheadline)
                .foregroundColor(ThemeColors.textSecondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeColors.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(ThemeColors.border, lineWidth: 1)
        )
    }
}

// MARK: - Thoughts View
struct ThoughtsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var animationId = UUID()
    
    @FetchRequest(
        entity: Thought.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Thought.content, ascending: true)],
        animation: .spring(response: 0.3))
    private var thoughts: FetchedResults<Thought>
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack(spacing: 16) {
                    if thoughts.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "brain.head.profile")
                                .font(.system(size: 48))
                                .foregroundColor(ThemeColors.textSecondary)
                            
                            Text("No Thoughts Recorded Yet")
                                .font(.headline)
                                .foregroundColor(ThemeColors.textPrimary)
                            
                            Text("Start capturing your thoughts and reflections to track your mental health journey.")
                                .font(.subheadline)
                                .foregroundColor(ThemeColors.textSecondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height - 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ForEach(thoughts) { thought in
                            NavigationLink(value: NavigationDestination.thought(thought)) {
                                ThoughtRow(thought: thought)
                                    .id(thought.id)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.9).combined(with: .opacity),
                                removal: .scale(scale: 0.9).combined(with: .opacity)
                            ))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
                .padding(.bottom, 100)
            }
        }
        .background(ThemeColors.background)
        .navigationTitle("Thoughts I've Had")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(value: NavigationDestination.newThought) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct ThoughtRow: View {
    @ObservedObject var thought: Thought
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let diagnosis = thought.diagnosis {
                Text(diagnosis)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .italic()
            }
            
            Text(thought.content ?? "No Content")
                .font(.body)
                .foregroundColor(ThemeColors.textPrimary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(ThemeColors.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(ThemeColors.border, lineWidth: 1)
        )
    }
}

struct ThoughtDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @State private var isLoaded = false
    @State private var showingDeleteConfirmation = false
    @State private var showingAddDiagnosisPrompt = false
    @State private var currentThought: Thought?
    
    @Binding var thought: Thought?
    @State private var content: String = ""
    @State private var selectedDiagnosis: String = "Other"
    @State private var customDiagnosis: String = ""
    
    private let otherDiagnosis = "Other"
    
    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: []
    ) var client: FetchedResults<Client>

    private let defaultOptions = ["General", "Into the Void"]
    
    private var assignedDiagnoses: [String] {
        let diagnoses = client.first?.disordersArray.map { $0.name ?? "" } ?? []
        return diagnoses.isEmpty ? [otherDiagnosis] : diagnoses
    }
    
    private var allOptions: [String] {
        defaultOptions + assignedDiagnoses + [otherDiagnosis]
    }
    
    private var shouldShowAddDiagnosis: Bool {
        !defaultOptions.contains(selectedDiagnosis) && 
        selectedDiagnosis != otherDiagnosis && 
        assignedDiagnoses.count <= 1
    }
    
    private var isFormValid: Bool {
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Don't validate "Into the Void" - it's meant to be ephemeral
        if selectedDiagnosis == "Into the Void" {
            return !trimmedContent.isEmpty
        }
        
        // For other diagnoses, require content
        return !trimmedContent.isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                // Diagnosis
                VStack(alignment: .leading, spacing: 8) {
                    Text("Related to")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeColors.textSecondary)
                    VStack(alignment: .leading) {
                        Menu {
                            ForEach(allOptions, id: \.self) { option in
                                Button(action: {
                                    selectedDiagnosis = option
                                }) {
                                    Text(option)
                                        .foregroundColor(ThemeColors.textPrimary)
                                }
                            }
                            if shouldShowAddDiagnosis {
                                Button(action: {
                                    showingAddDiagnosisPrompt = true
                                }) {
                                    Text("Add Diagnosis")
                                        .foregroundColor(.white)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedDiagnosis)
                                    .foregroundColor(ThemeColors.textPrimary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(ThemeColors.textSecondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(ThemeColors.cardBackground)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(ThemeColors.border, lineWidth: 1)
                        )
                        
                        if selectedDiagnosis == otherDiagnosis {
                            TextField("Specific Other Disorder", text: $customDiagnosis)
                                .textFieldStyle(ModernTextFieldStyle())
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                    }
                }
                .opacity(isLoaded ? 1 : 0)
                .offset(y: isLoaded ? 0 : 20)
                .padding(.horizontal)
                
                // Thought Content
                TextField("Write your thought...", text: $content, axis: .vertical)
                    .textFieldStyle(ModernTextFieldStyle())
                    .foregroundColor(ThemeColors.textPrimary)
                    .opacity(isLoaded ? 1 : 0)
                    .offset(y: isLoaded ? 0 : 20)
                    .padding(.horizontal)
            }
            .padding(.top)
            .padding(.bottom, 100)
        }
        .background(ThemeColors.background)
        .navigationBarBackButtonHidden()
        .navigationTitle("Thought")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { 
                    // Don't save empty thoughts when dismissing
                    let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmedContent.isEmpty {
                        if let existingThought = currentThought {
                            viewContext.delete(existingThought)
                            try? viewContext.save()
                        }
                    } else {
                        saveOrUpdateThought()
                    }
                    dismiss()
                }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
            if thought != nil {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveOrUpdateThought()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        Image("trash")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveOrUpdateThought()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .alert("Delete Thought", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let thought = thought {
                    viewContext.delete(thought)
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("Error deleting thought: \(error)")
                    }
                }
            }
        } message: {
            Text("Are you sure you want to delete this thought? This action cannot be undone.")
        }
        .alert("Add Diagnosis", isPresented: $showingAddDiagnosisPrompt) {
            Button("Cancel", role: .cancel) { }
            NavigationLink(value: NavigationDestination.profile) {
                Text("Go to Profile")
            }
        } message: {
            Text("You haven't added any diagnoses yet. Would you like to add them in your profile?")
        }
        .onAppear {
            // Initialize the currentThought with the passed thought
            currentThought = thought
            
            if let thoughtContent = thought?.content {
                content = thoughtContent
            }
            if let diagnosis = thought?.diagnosis {
                if allOptions.contains(diagnosis) {
                    selectedDiagnosis = diagnosis
                } else {
                    selectedDiagnosis = otherDiagnosis
                    customDiagnosis = diagnosis
                }
            } else {
                selectedDiagnosis = "General"
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                isLoaded = true
            }
        }
    }


    private func saveOrUpdateThought() {
        // Don't save if it's "Into the Void"
        if selectedDiagnosis == "Into the Void" {
            return
        }

        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // If content is empty, delete the thought if it exists
        if trimmedContent.isEmpty {
            if let existingThought = currentThought {
                viewContext.delete(existingThought)
                currentThought = nil
                thought = nil
                do {
                    try viewContext.save()
                } catch {
                    print("Error deleting empty thought: \(error)")
                }
            }
            return
        }
        
        // Create a new thought only if we don't have one yet and have valid content
        if currentThought == nil {
            currentThought = Thought(context: viewContext)
        }
        
        // Update the existing thought
        if let thoughtToUpdate = currentThought {
            thoughtToUpdate.content = trimmedContent
            thoughtToUpdate.diagnosis = selectedDiagnosis == otherDiagnosis ? customDiagnosis : selectedDiagnosis
            thought = thoughtToUpdate
            
            do {
                try viewContext.save()
            } catch {
                print("Error saving thought: \(error)")
                // If save fails, delete the thought to prevent corruption
                if currentThought != nil && thought == nil {
                    viewContext.delete(thoughtToUpdate)
                    currentThought = nil
                }
            }
        }
    }
}

// MARK: - Date Formatting
extension View {
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - New Goal View
struct NewGoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @Binding var goalToEdit: Treatment?
    @State private var isLoaded = false
    @State private var showingDeleteConfirmation = false
    @State private var showingAddDiagnosisPrompt = false
    @State private var currentGoal: Treatment?

    @State private var selectedDiagnosis: String = "Other"
    @State private var customDiagnosis: String = ""
    @State private var goalDescription: String = ""
    @State private var goalGoal: String = ""
    
    private let otherDiagnosis = "Other"
    
    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: []
    ) var client: FetchedResults<Client>

    private var assignedDiagnoses: [String] {
        let diagnoses = client.first?.disordersArray.map { $0.name ?? "" } ?? []
        return diagnoses.isEmpty ? [otherDiagnosis] : diagnoses + [otherDiagnosis]
    }
    
    private var isFormValid: Bool {
        let trimmedGoal = goalGoal.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = goalDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedCustomDiagnosis = customDiagnosis.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Check if goal and description are filled
        let hasGoal = !trimmedGoal.isEmpty
        let hasDescription = !trimmedDescription.isEmpty
        
        // If "Other" is selected, custom diagnosis must be filled
        let hasValidDiagnosis = selectedDiagnosis != otherDiagnosis || !trimmedCustomDiagnosis.isEmpty
        
        return hasGoal && hasDescription && hasValidDiagnosis
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Diagnosis
                VStack(alignment: .leading, spacing: 8) {
                    Text("What area are you working on?")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeColors.textSecondary)
                    VStack(alignment: .leading) {
                        Menu {
                            ForEach(assignedDiagnoses, id: \.self) { diagnosis in
                                Button(action: {
                                    selectedDiagnosis = diagnosis
                                }) {
                                    Text(diagnosis)
                                        .foregroundColor(ThemeColors.textPrimary)
                                }
                            }
                            if assignedDiagnoses.count == 1 {
                                Button(action: {
                                    showingAddDiagnosisPrompt = true
                                }) {
                                    Text("Add Diagnosis")
                                        .foregroundColor(.white)
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedDiagnosis)
                                    .foregroundColor(ThemeColors.textPrimary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(ThemeColors.textSecondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(ThemeColors.cardBackground)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(ThemeColors.border, lineWidth: 1)
                        )
                        
                        if selectedDiagnosis == otherDiagnosis {
                            TextField("Specific Other Disorder", text: $customDiagnosis)
                                .textFieldStyle(ModernTextFieldStyle())
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                    }
                }
                .opacity(isLoaded ? 1 : 0)
                .offset(y: isLoaded ? 0 : 20)
                
                // Goal
                VStack(alignment: .leading, spacing: 8) {
                    Text("Goal")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeColors.textSecondary)
                    TextField("What is your goal...", text: $goalGoal, axis: .vertical)
                        .textFieldStyle(ModernTextFieldStyle())
                        .foregroundColor(ThemeColors.textPrimary)
                }
                .opacity(isLoaded ? 1 : 0)
                .offset(y: isLoaded ? 0 : 20)
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(ThemeColors.textSecondary)
                    TextField("Description of your goal...", text: $goalDescription, axis: .vertical)
                        .textFieldStyle(ModernTextFieldStyle())
                        .foregroundColor(ThemeColors.textPrimary)
                }
                .opacity(isLoaded ? 1 : 0)
                .offset(y: isLoaded ? 0 : 20)
            }
            .padding()
            .padding(.bottom, 100)
        }
        .background(ThemeColors.background)
        .navigationBarBackButtonHidden()
        .navigationTitle("Goals")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { 
                    // Don't save empty goals when dismissing
                    let trimmedGoal = goalGoal.trimmingCharacters(in: .whitespacesAndNewlines)
                    let trimmedDescription = goalDescription.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    if trimmedGoal.isEmpty && trimmedDescription.isEmpty {
                        if let existingGoal = currentGoal {
                            viewContext.delete(existingGoal)
                            try? viewContext.save()
                        }
                    }
                    dismiss() 
                }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
            if goalToEdit != nil {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveOrUpdateGoal()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        Image("trash")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.red)
                            .frame(width: 24, height: 24)
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        saveOrUpdateGoal()
                        dismiss()
                    }) {
                        Image("check")
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 18, height: 18)
                            .foregroundColor(isFormValid ? .white : ThemeColors.textSecondary)
                    }
                    .disabled(!isFormValid)
                }
            }
        }
        .keyboardToolbar()
        .alert("Delete Goal", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let goal = goalToEdit {
                    viewContext.delete(goal)
                    do {
                        try viewContext.save()
                        dismiss()
                    } catch {
                        print("Error deleting goal: \(error)")
                    }
                }
            }
        } message: {
            Text("Are you sure you want to delete this treatment goal? This action cannot be undone.")
        }
        .alert("Add Diagnosis", isPresented: $showingAddDiagnosisPrompt) {
            Button("Cancel", role: .cancel) { }
            NavigationLink(value: NavigationDestination.profile) {
                Text("Go to Profile")
            }
        } message: {
            Text("You haven't added any diagnoses yet. Would you like to add them in your profile?")
        }
        .onAppear {
            currentGoal = goalToEdit
            if let goal = goalToEdit {
                goalGoal = goal.goal ?? ""
                goalDescription = goal.desc ?? ""
                let goalDiagnosis = goal.diagnosis ?? ""
                if assignedDiagnoses.contains(goalDiagnosis) {
                    selectedDiagnosis = goalDiagnosis
                } else {
                    selectedDiagnosis = otherDiagnosis
                    customDiagnosis = goalDiagnosis
                }
            }
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                isLoaded = true
            }
        }
    }

    private func saveOrUpdateGoal() {
        let trimmedGoal = goalGoal.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = goalDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // If required fields are empty, delete the goal if it exists and return
        if trimmedGoal.isEmpty && trimmedDescription.isEmpty {
            if let existingGoal = currentGoal {
                viewContext.delete(existingGoal)
                currentGoal = nil
                goalToEdit = nil
                do {
                    try viewContext.save()
                } catch {
                    print("Error deleting empty goal: \(error)")
                }
            }
            return
        }
        
        // Don't create or save if both goal and description are empty
        if trimmedGoal.isEmpty && trimmedDescription.isEmpty {
            return
        }
        
        // Create a new goal only if we don't have one yet and have valid content
        if currentGoal == nil {
            currentGoal = Treatment(context: viewContext)
        }
        
        // Update the goal only if we have valid content
        if let goalToUpdate = currentGoal {
            let finalDiagnosis = selectedDiagnosis == otherDiagnosis ? customDiagnosis : selectedDiagnosis
            
            // Validate that we have at least some content
            guard !trimmedGoal.isEmpty || !trimmedDescription.isEmpty else {
                return
            }
            
            goalToUpdate.diagnosis = finalDiagnosis
            goalToUpdate.desc = trimmedDescription
            goalToUpdate.goal = trimmedGoal
            goalToEdit = goalToUpdate
            
            do {
                try viewContext.save()
            } catch {
                print("Error saving goal: \(error)")
                // If save fails, delete the goal to prevent corruption
                if currentGoal != nil && goalToEdit == nil {
                    viewContext.delete(goalToUpdate)
                    currentGoal = nil
                }
            }
        }
    }
}

// All Conversations View
struct AllSessionsView: View {
    let sessions: [Session]
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSession: Session?

    var body: some View {
        VStack(spacing: 0) {
            if sessions.isEmpty {
                Text("No upcoming sessions")
                    .font(.headline)
                    .foregroundColor(ThemeColors.textSecondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(sessions) { session in
                            NavigationLink(value: NavigationDestination.session(session)) {
                                UpcomingEventCard(session: session)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 100)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("Chats")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .background(ThemeColors.background)
    }
}

struct Therapist: Identifiable, Hashable, Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var website: String
    var isActive: Bool
    var notes: String
    
    init(firstName: String = "", lastName: String = "", email: String = "", phoneNumber: String = "", website: String = "", isActive: Bool = true, notes: String = "") {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.website = website
        self.isActive = isActive
        self.notes = notes
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    static func == (lhs: Therapist, rhs: Therapist) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class TherapistManager: ObservableObject {
    @Published var therapists: [Therapist] = []
    
    init() {
        // Load therapists from UserDefaults
        if let data = UserDefaults.standard.data(forKey: "savedTherapists"),
           let decoded = try? JSONDecoder().decode([Therapist].self, from: data) {
            therapists = decoded
        }
    }
    
    func addTherapist(_ therapist: Therapist) {
        therapists.append(therapist)
        saveTherapists()
    }
    
    func updateTherapist(_ updatedTherapist: Therapist) {
        if let index = therapists.firstIndex(where: { $0.id == updatedTherapist.id }) {
            therapists[index] = updatedTherapist
            saveTherapists()
        }
    }
    
    func removeTherapist(_ therapist: Therapist) {
        therapists.removeAll { $0.id == therapist.id }
        saveTherapists()
    }
    
    private func saveTherapists() {
        if let encoded = try? JSONEncoder().encode(therapists) {
            UserDefaults.standard.set(encoded, forKey: "savedTherapists")
        }
    }
}

// MARK: - Animation Modifiers
struct SlideInTransition: ViewModifier {
    let edge: Edge
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .transition(.move(edge: edge).combined(with: .opacity))
    }
}

struct ScaleTransition: ViewModifier {
    func body(content: Content) -> some View {
        content
            .transition(.scale(scale: 0.9).combined(with: .opacity))
    }
}

struct SmoothTransition<Value: Equatable>: ViewModifier {
    let value: Value
    
    func body(content: Content) -> some View {
        content
            .animation(.spring(response: 0.3, dampingFraction: 0.8), value: value)
    }
}

extension View {
    func slideInTransition(_ edge: Edge = .leading) -> some View {
        modifier(SlideInTransition(edge: edge))
    }
    
    func scaleTransition() -> some View {
        modifier(ScaleTransition())
    }
    
    func smoothTransition<Value: Equatable>(value: Value) -> some View {
        modifier(SmoothTransition(value: value))
    }
}


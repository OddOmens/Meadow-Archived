/*
import SwiftUI
import CoreData
import Foundation

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
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedTab = 1
    @State private var isSwipeDisabled = true
    

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(1)

            NavigationView {
                TreatmentView()
            }
            .tabItem {
                Label("Treatment", systemImage: "heart")
            }
            .tag(2)

            NavigationView {
                ThoughtsView()
            }
            .tabItem {
                Label("Thoughts", systemImage: "brain")
            }
            .tag(3)

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
            .tag(4)

            NavigationView {
                SettingsView(themeManager: themeManager)
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(5)
        }
        .onChange(of: selectedTab) { oldTab, newTab in
            // Handle tab change if needed
        }
        .navigationBarHidden(true)
        .overlay(BottomNavigationBar(selectedTab: $selectedTab, isSwipeDisabled: $isSwipeDisabled), alignment: .bottom)
    }
}

struct BottomNavigationBar: View {
    @Binding var selectedTab: Int
    @Binding var isSwipeDisabled: Bool
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack (spacing: 0) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)
            
            HStack {
                TabBarButton(tabIndex: 1, imageName: "calendar-lines-pen", textName: "Sessions", selectedTab: $selectedTab)
                TabBarButton(tabIndex: 2, imageName: "notes", textName: "Treatment", selectedTab: $selectedTab)
                TabBarButton(tabIndex: 3, imageName: "memo", textName: "Thoughts", selectedTab: $selectedTab)
                TabBarButton(tabIndex: 4, imageName: "user", textName: "Profile", selectedTab: $selectedTab)
                TabBarButton(tabIndex: 5, imageName: "gear", textName: "Settings", selectedTab: $selectedTab)
            }
            .padding(.top, 5)
            .padding(.bottom, 0)
            .frame(maxWidth: .infinity)
            .background(Color.colorSecondary)
            .foregroundColor(Color.colorSecondary)
        }
    }
}


struct TabBarButton: View {
    let tabIndex: Int
    let imageName: String
    let textName: String
    
    @EnvironmentObject var userSettings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var selectedTab: Int
    
    var body: some View {
        Button(action: {
            selectedTab = tabIndex
        }) {
            VStack {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(selectedTab == tabIndex ? Color.colorActiveTab : Color.colorPrimary)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: userSettings.showNavLabels ? 22 : 26, height: userSettings.showNavLabels ? 26 : 26)
                    .padding(.bottom, userSettings.showNavLabels ? 0 : -12) // Add top padding when text is
                    .padding(.top, userSettings.showNavLabels ? 0 : 12) // Add top padding when text is
                
                Text(textName)
                    .font(.caption)
                    .foregroundColor(selectedTab == tabIndex ? Color.colorActiveTab : Color.colorPrimary)
                    .opacity(userSettings.showNavLabels ? 1 : 0) // Make the text invisible
            }
            .padding(8)
        }
    }
}



//MARK: - App Code
struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var themeManager: ThemeManager
    
    @FetchRequest(
        entity: Session.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: false)]
    ) var sessions: FetchedResults<Session>
    
    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: []
    ) var clients: FetchedResults<Client>
    
    @State private var showingSettings = false
    @State private var showingSession = false
    @State private var showingProfile = false
    @State private var greetingMessage: String = ""
    @State private var editingSession: Session?
    @State private var showingDeleteConfirmation = false
    @State private var sessionToDelete: Session?
    
    private var upcomingSessions: [Session] {
        sessions.filter { $0.date ?? Date() > Date() }
                .sorted { ($0.date ?? Date()) < ($1.date ?? Date()) }
    }

    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 22, height: 22)
                
                Spacer()
                
                Text("Sessions")
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: SessionView(session: nil)) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.colorPrimary)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
            }.padding(.horizontal).padding(.vertical,10)
            if !upcomingSessions.isEmpty {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.cusGrey) // Adjust the color as needed
                    .frame(maxWidth: .infinity)
            }
            
            VStack {
                // MARK: - Upcoming Sessions Section
                if !upcomingSessions.isEmpty {
                    TabView {
                        ForEach(upcomingSessions, id: \.self) { session in
                            NavigationLink(destination: SessionView(session: session)) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("UPCOMING SESSION :")
                                            .font(.system(size: 10))
                                            .bold()
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            self.deleteSpecificSession(session)
                                        }) {
                                            Image("xmark")
                                                .resizable()
                                                .renderingMode(.template)
                                                .foregroundColor(Color.colorPrimary)
                                                .scaledToFit()
                                                .frame(width: 18, height: 18)
                                        }
                                    }
                                    
                                    Text(session.title ?? "Session")
                                        .font(.system(size: 24))
                                        .bold()
                                        .padding(.vertical, 1)
                                    
                                    HStack {
                                        Image("calendar")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(Color.colorPrimary)
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                        
                                        Text(formatDate(session.date ?? Date()))
                                            .font(.system(size: 12))
                                        
                                        Image("clock")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundColor(Color.colorPrimary)
                                            .scaledToFit()
                                            .frame(width: 18, height: 18)
                                        
                                        Text(formatTime(session.date ?? Date()))
                                            .font(.system(size: 12))
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.cusGrey)
                                .cornerRadius(15)
                                .padding([.leading, .trailing], 5)
                            }
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .automatic))
                    .frame(height: 140)
                    .padding(.top, 2)
                    


                }
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.cusGrey) // Adjust the color as needed
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, -50)
                
                // MARK: - Past Sessions Section
                List {
                    ForEach(Array(sessions.filter { $0.date ?? Date() < Date() }.enumerated()), id: \.element) { (index, session) in
                        NavigationLink(destination: SessionView(session: session)) {
                            VStack(alignment: .leading) {
                                Text("\(session.title ?? "Therapy Session")")
                                    .font(.system(size: 20))
                                    .bold()
                                    .padding(.bottom, -6)
                                Text("Session with \(session.therapist ?? "a therapist") to discuss \(session.purpose ?? "nothing specific.")")
                                    .font(.system(size: 12))
                                    .padding(.vertical, 4)
                                Text("\(formatDate(session.date ?? Date()))")
                                    .font(.system(size: 10))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .onDelete(perform: deleteSession)
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 55)
                }
                .listStyle(.inset)
                .listRowBackground(Color.clear)
                .padding(.bottom, 30)
                .edgesIgnoringSafeArea(.bottom)
                .padding([.leading, .trailing], -10)
                .padding(.top, -5)
            }
            .padding(.horizontal)
        }
    }
    
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
    
    private func deleteSession(at offsets: IndexSet) {
        for index in offsets {
            let session = sessions.filter { $0.date ?? Date() < Date() }[index]
            viewContext.delete(session)
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error deleting session: \(error.localizedDescription)")
        }
    }

    private func deleteSpecificSession(_ session: Session) {
        viewContext.delete(session)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting session: \(error.localizedDescription)")
        }
    }

    private func generateGreetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let greeting: String
        
        switch hour {
        case 0..<12: greeting = "Good morning"
        case 12..<17: greeting = "Good afternoon"
        case 17..<24: greeting = "Good evening"
        default: greeting = "Hello"
        }
        
        if let client = clients.first, let firstName = client.firstName, !firstName.isEmpty {
            return "\(greeting), \(firstName)."
        } else {
            return greeting
        }
    }
}


//MARK: - Profile View
struct ProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @State private var showingDisorderDetail = false
    @State private var showingDisordersList = false

    @State private var selectedDisorder: Disorder?

    // State variables for user input
    @State private var firstName: String = ""
    @State private var lastName: String = ""

    @FetchRequest(
        entity: Client.entity(),
        sortDescriptors: []
    ) var client: FetchedResults<Client>

    @FetchRequest(
        entity: Disorder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Disorder.name, ascending: true)]
    ) var disorders: FetchedResults<Disorder>

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 22, height: 22)
                
                Spacer()
                
                Text("My Information")
                    .bold()
                
                Spacer()
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 22, height: 22)
            }.padding(.horizontal).padding(.vertical,10)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)


            VStack {
                VStack(alignment: .leading){
                    HStack{
                        Text ("Personal Information")
                            .bold()

                        Spacer()
                    }

                    Divider()
                        .padding(.bottom, 5)

                    VStack(alignment: .leading) {
                        Text("FIRST NAME")
                            .font(.system(size: 10))
                            .bold()
                        TextField("First name...", text: $firstName)
                            .onChange(of: firstName) { oldValue, newValue in
                                saveClient()
                            }
                    }.padding(.bottom, 10)
                        .listRowSeparator(.hidden)

                    VStack(alignment: .leading) {
                        Text("LAST NAME")
                            .font(.system(size: 10))
                            .bold()
                        TextField("Last name...", text: $lastName)
                            .onChange(of: lastName) { oldValue, newValue in
                                saveClient()
                            }
                    }
                    .listRowSeparator(.hidden)
                }.onAppear {
                    if let client = client.first {
                        firstName = client.firstName ?? ""
                        lastName = client.lastName ?? ""
                    }
                }.listStyle(PlainListStyle()) // Use PlainListStyle for a more custom look
                    .listRowSeparator(.hidden)
                    .padding(.bottom, 15)

                VStack(alignment: .leading){
                    HStack {
                        Text ("Diagnoses")
                            .bold()

                        Spacer()

                        Button(action: {
                            // Ensure there's a client record, creating one if needed
                            if client.first == nil {
                                let newClient = Client(context: viewContext)
                                try? viewContext.save()
                            }
                            showingDisordersList = true
                        }) {
                            Image("plus")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color.colorPrimary)
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                        }
                        .sheet(isPresented: $showingDisordersList) {
                            if let currentClient = client.first {
                                DisordersListView(client: currentClient, viewContext: viewContext)
                            }
                        }
                    }

                    Divider()

                    List {
                        ForEach(client.first?.disordersArray ?? [], id: \.self) { disorder in
                            VStack(alignment: .leading) {
                                Text(disorder.name ?? "Unknown")
                                if selectedDisorder == disorder {
                                    Text(disorder.desc ?? "No description available")
                                        .font(.caption)
                                        .transition(.opacity)
                                }
                            }
                            .onTapGesture {
                                if selectedDisorder == disorder {
                                    selectedDisorder = nil
                                } else {
                                    selectedDisorder = disorder
                                }
                            }
                        }
                        .onDelete(perform: deleteDisorder)
                    }.padding(.horizontal, -20)
                        .listStyle(PlainListStyle()) // Use PlainListStyle for a more custom look
                }
                .frame(maxHeight: .infinity) // Attempt to fill available vertical space
                .listStyle(PlainListStyle()) // Use PlainListStyle for a more custom look
            }.padding()
        }
    }


    private func saveClient() {
        let client: Client

        // Check if a Client already exists, otherwise create a new one
        let request: NSFetchRequest<Client> = Client.fetchRequest()
        if let existingClient = try? viewContext.fetch(request).first {
            client = existingClient
        } else {
            client = Client(context: viewContext)
        }

        // Update the client with the new information
        client.firstName = firstName
        client.lastName = lastName

        do {
            try viewContext.save()
        } catch {
            print("Error saving Client: \(error)")
        }
    }

    private func deleteDisorder(at offsets: IndexSet) {
        // Ensure there is a client object to work with
        if let clientObject = client.first {
            for index in offsets {
                let disorder = clientObject.disordersArray[index] // Access the client object's disordersArray
                clientObject.removeFromDisorders(disorder)
                viewContext.delete(disorder)
            }
            do {
                try viewContext.save()
            } catch {
                print("Error saving context after deleting disorder: \(error)")
            }
        }
    }

}

struct DisorderItem {
    var name: String
    var desc: String // Ensure this matches what you use when initializing
}

struct DisordersListView: View {
    @ObservedObject var client: Client
    var viewContext: NSManagedObjectContext
    
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
        VStack {
            HStack {
                Spacer()
                
                Text("Diagnosis")
                    .bold()
                
                Spacer()
                
            }.padding(.horizontal).padding(.top,10)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)
            
            List {
                ForEach(groupedDisorders.keys.sorted(), id: \.self) { sectionKey in
                    Section(header: Text(sectionKey)) {
                        ForEach(groupedDisorders[sectionKey]!, id: \.name) { disorder in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(disorder.name)
                                        .bold()
                                    Text(disorder.desc)
                                        .font(.caption)
                                }
                                Spacer()
                                Image(systemName: clientHasDisorder(disorder) ? "checkmark.circle.fill" : "plus.circle.fill")
                                    .foregroundColor(clientHasDisorder(disorder) ? .green : Color.colorPrimary)
                                    .onTapGesture {
                                        // Directly add or remove the disorder without checking for names
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
            .listStyle(.inset)
        }
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
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
        entity: Session.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Session.date, ascending: true)]
    ) var sessions: FetchedResults<Session>

    var session: Session? // Optional Session object

    @State private var title: String = ""
    @State private var advice: String = ""
    @State private var date: Date = Date()
    @State private var therapist: String = ""
    @State private var purpose: String = ""
    @State private var notes: String = ""
    
    @FocusState private var focusedField: Field?
    
    private enum Field: Hashable {
        case therapist, title, purpose, advice, notes
    }
    
    init(session: Session?) {
        self.session = session
        _title = State(initialValue: session?.title ?? "")
        _advice = State(initialValue: session?.advice ?? "")
        _date = State(initialValue: session?.date ?? Date())
        _therapist = State(initialValue: session?.therapist ?? "")
        _purpose = State(initialValue: session?.purpose ?? "")
        _notes = State(initialValue: session?.notes ?? "")
    }
    
    private var sessionCount: Int {
        sessions.count
    }

    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey)
                .frame(maxWidth: .infinity)

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("THERAPIST")
                                .font(.system(size: 10))
                                .bold()
                            TextField("Therapist", text: $therapist)
                                .focused($focusedField, equals: .therapist)
                                .id(Field.therapist)
                        }
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Text("SESSION TITLE")
                                .font(.system(size: 10))
                                .bold()
                            TextField("Session title", text: $title)
                                .focused($focusedField, equals: .title)
                                .id(Field.title)
                        }
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Text("APPOINTMENT DATE")
                                .font(.system(size: 10))
                                .bold()
                            DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                                .labelsHidden()
                        }
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading) {
                            Text("SESSION PURPOSE")
                                .font(.system(size: 10))
                                .bold()
                            TextField("Purpose of your session...", text: $purpose, axis: .vertical)
                                .focused($focusedField, equals: .purpose)
                                .id(Field.purpose)
                        }
                        .padding(.bottom, 10)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("THERAPIST ADVICE")
                                .font(.system(size: 10))
                                .bold()
                            TextField("Therapists advice...", text: $advice, axis: .vertical)
                                .focused($focusedField, equals: .advice)
                                .id(Field.advice)
                        }
                        .padding(.bottom, 10)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("NOTES")
                                .font(.system(size: 8))
                                .bold()
                            TextField("Session notes...", text: $notes, axis: .vertical)
                                .focused($focusedField, equals: .notes)
                                .id(Field.notes)
                        }
                    }
                    .padding()
                    .padding(.bottom, 80) // Add extra padding at the bottom to account for navigation bar
                }
                .onChange(of: focusedField) { oldValue, newValue in
                    if let field = newValue {
                        withAnimation {
                            proxy.scrollTo(field, anchor: .center)
                        }
                    }
                }
                #if canImport(UIKit)
                .ignoresSafeArea(.keyboard, edges: .bottom)
                #endif
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 55) // Match the height of your navigation bar
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(session == nil ? "New Session" : "Edit Session")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.colorPrimary)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.black)
                }
            }
        }
        .onDisappear {
            if session == nil && (title.isEmpty && therapist.isEmpty && purpose.isEmpty && advice.isEmpty && notes.isEmpty) {
                // Do nothing, session will not be created
            } else {
                saveData()
            }
        }
    }
    
    private func saveData() {
        let sessionToSave = session ?? Session(context: viewContext)
        
        sessionToSave.title = title
        sessionToSave.advice = advice
        sessionToSave.count = Double(sessionCount + 1)
        sessionToSave.date = date
        sessionToSave.therapist = therapist
        sessionToSave.purpose = purpose
        sessionToSave.notes = notes
        sessionToSave.id = session?.id ?? UUID()

        do {
            try viewContext.save()
        } catch {
            print("Error saving session: \(error.localizedDescription)")
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}


//MARK: - Treatment View
struct TreatmentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Treatment.diagnosis, ascending: true)],
        animation: .default)
    private var treatment: FetchedResults<Treatment>
    
    @State private var editingGoal: Treatment?
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 22, height: 22)
                
                Spacer()
                
                Text("Treatment Goals")
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: NewGoalView(goalToEdit: $editingGoal)) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.colorPrimary)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
            }.padding(.horizontal).padding(.vertical,10)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)

            List {
                ForEach(treatment) { goal in
                    NavigationLink(destination: NewGoalView(goalToEdit: .constant(goal))) { // Navigate to edit goal
                        VStack(alignment: .leading) {
                            Text("Treatment for \(goal.diagnosis ?? "Unknown Diagnosis")")
                                .font(.system(size: 14))
                                .foregroundColor(Color.colorPrimary)
                                .italic()
                                .padding(.bottom, 2)
                            
                            Text(goal.goal ?? "Unknown Goal")
                                .font(.system(size: 16))
                                .foregroundColor(Color.colorPrimary)
                                .bold()
                                .padding(.bottom, -2)
                            
                            Text(goal.desc ?? "Unknown Description")
                                .font(.system(size: 12))
                                .foregroundColor(Color.colorPrimary)
                        }
                    }
                }
                .onDelete(perform: deleteGoals)
            }.listStyle(.inset)
            .listStyle(PlainListStyle())
            .listRowBackground(Color.clear)

        }.safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 15) // Adjust this height based on your bottom navigation bar's height
        }
    }

    private func deleteGoals(offsets: IndexSet) {
        for index in offsets {
            let goal = treatment[index]
            viewContext.delete(goal)
        }
        do {
            try viewContext.save()
        } catch {
            // Handle the Core Data error
        }
    }
}

struct NewGoalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @Binding var goalToEdit: Treatment?

    @State private var selectedDiagnosis: String = "Other" // Default to "Other"
    @State private var customDiagnosis: String = ""
    @State private var goalDescription: String = ""
    @State private var goalGoal: String = ""
    
    private let otherDiagnosis = "Other"
    
    @FetchRequest(
        entity: Disorder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Disorder.name, ascending: true)]
    ) private var diagnoses: FetchedResults<Disorder>

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)
            
            List {
                VStack(alignment: .leading) {
                    Text("Treatment Goal")
                        .font(.system(size: 10))
                        .bold()
                        .listRowSeparator(.hidden)
                    TextField("What is your treatment goal...", text: $goalGoal, axis: .vertical)
                }.listRowSeparator(.hidden)
                
                VStack(alignment: .leading) {
                    Text("What are you treating?")
                        .font(.system(size: 10))
                        .bold()
                        .listRowSeparator(.hidden)
                    HStack {
                        Picker("", selection: $selectedDiagnosis) {
                            ForEach(diagnoses, id: \.self) { diagnosis in
                                Text(diagnosis.name ?? "Unknown").tag(diagnosis.name ?? "Unknown")
                                    .foregroundColor(Color.colorPrimary)
                            }
                            Text(otherDiagnosis).tag(otherDiagnosis)
                                .foregroundColor(Color.colorPrimary)
                        }
                        .accentColor(Color.colorPrimary) // Set the accent color for the picker
                        .labelsHidden()
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedDiagnosis) { oldValue, newValue in
                            if newValue != otherDiagnosis {
                                customDiagnosis = "" // Ensure custom diagnosis is cleared if not using 'Other'
                            }
                        }
                        
                        // Determine if we should display the other diagnosis textfield
                        if selectedDiagnosis == otherDiagnosis {
                            TextField("Specific Other Disorder", text: $customDiagnosis)
                                .foregroundColor(Color.colorPrimary)
                        }
                    }.padding(.leading, -10)
                }.listRowSeparator(.hidden)
                
                VStack(alignment: .leading) {
                    Text("Treatment Description")
                        .font(.system(size: 10))
                        .bold()
                        .listRowSeparator(.hidden)
                    TextField("Description of your treatment goal...", text: $goalDescription, axis: .vertical)
                }.listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 15) // Adjust this height based on your bottom navigation bar's height
            }
            .onAppear {
                if let goal = goalToEdit {
                    // Populate form fields with existing values
                    goalGoal = goal.goal ?? ""
                    goalDescription = goal.desc ?? ""
                    let goalDiagnosis = goal.diagnosis ?? ""
                    if diagnoses.contains(where: { $0.name == goalDiagnosis }) {
                        selectedDiagnosis = goalDiagnosis
                    } else {
                        selectedDiagnosis = otherDiagnosis
                        customDiagnosis = goalDiagnosis // Capture the exact, specific disorder label
                    }
                }
            }
            .onDisappear {
                saveOrUpdateGoal()
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationTitle(goalToEdit != nil ? "Edit Goal" : "Add New Goal")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.colorPrimary)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.black)
                }
            }
        }
    }

    private func saveOrUpdateGoal() {
        // Check if the fields are empty before saving
        if goalGoal.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            goalDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            selectedDiagnosis == otherDiagnosis && customDiagnosis.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            // Do not create a treatment if all fields are empty
            return
        }
        
        let goalToSave = goalToEdit ?? Treatment(context: viewContext)
        goalToSave.diagnosis = selectedDiagnosis == otherDiagnosis ? customDiagnosis : selectedDiagnosis
        goalToSave.desc = goalDescription
        goalToSave.goal = goalGoal

        do {
            try viewContext.save()
        } catch {
            print("Error saving goal: \(error.localizedDescription)")
        }
    }
}




// MARK: - Mood Tracker Section
struct ThoughtsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Thought.content, ascending: true)],
        animation: .default)
    private var thoughts: FetchedResults<Thought>

    @State private var showingThoughtDetailView = false
    @State private var editingThought: Thought?

    var body: some View {
        VStack {
            
            HStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 22, height: 22)
                
                Spacer()
                
                Text("Thoughts I've Had")
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: ThoughtDetailView(thought: $editingThought)) {
                    Image("plus")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.colorPrimary)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                }
            }.padding(.horizontal).padding(.vertical,10)
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)

            List {
                ForEach(thoughts) { thought in
                    NavigationLink(destination: ThoughtDetailView(thought: .constant(thought))) { // Navigate to edit thought
                        VStack(alignment: .leading) {
                            Text(thought.content ?? "No Content")
                                .foregroundColor(Color.colorPrimary)
                        }
                    }
                }
                .onDelete(perform: deleteThoughts)
            }
            .listStyle(.inset)
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 15) // Adjust this height based on your bottom navigation bar's height
        }
    }

    private func deleteThoughts(offsets: IndexSet) {
        for index in offsets {
            let thought = thoughts[index]
            viewContext.delete(thought)
        }
        do {
            try viewContext.save()
        } catch {
            print("Error saving context after deleting a thought: \(error)")
        }
    }
}

struct ThoughtDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var thought: Thought?
    @State private var content: String = ""

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.cusGrey) // Adjust the color as needed
                .frame(maxWidth: .infinity)
            
            TextEditor(text: $content)
                .padding()
                .onAppear {
                    if let thoughtContent = thought?.content {
                        content = thoughtContent
                    }
                }
                .onDisappear {
                    saveOrUpdateThought()
                }
        }
        .navigationBarBackButtonHidden()
        .navigationTitle("A Thought I Had...")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image("arrow-left")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.colorPrimary)
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.black)
                }
            }
        }
    }

    private func saveOrUpdateThought() {
        if content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if let existingThought = thought {
                viewContext.delete(existingThought)
            }
        } else {
            let thoughtToSave = thought ?? Thought(context: viewContext)
            thoughtToSave.content = content

            do {
                try viewContext.save()
            } catch {
                print("Error saving thought: \(error)")
            }
        }
        
        dismiss()
    }
}
*/

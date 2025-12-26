import CoreData
import Foundation

class DemoDataHelper {
    static func loadDemoData(context: NSManagedObjectContext) {
        // Clear existing data first
        clearAllData(context: context)
        
        // Create demo providers
        let providers = createDemoProviders(context: context)
        
        // Create demo sessions
        createDemoSessions(context: context, providers: providers)
        
        // Create demo goals/treatments
        createDemoTreatments(context: context)
        
        // Create demo thoughts
        createDemoThoughts(context: context)
        
        // Save context
        do {
            try context.save()
            print("✅ Demo data loaded successfully")
        } catch {
            print("❌ Error saving demo data: \(error)")
        }
    }
    
    // Load only providers
    static func loadDemoProviders(context: NSManagedObjectContext) {
        _ = createDemoProviders(context: context)
        do {
            try context.save()
            print("✅ Demo providers loaded successfully")
        } catch {
            print("❌ Error saving demo providers: \(error)")
        }
    }
    
    // Load only sessions
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
    
    // Load only treatments
    static func loadDemoTreatments(context: NSManagedObjectContext) {
        createDemoTreatments(context: context)
        do {
            try context.save()
            print("✅ Demo treatments loaded successfully")
        } catch {
            print("❌ Error saving demo treatments: \(error)")
        }
    }
    
    // Load only thoughts
    static func loadDemoThoughts(context: NSManagedObjectContext) {
        createDemoThoughts(context: context)
        do {
            try context.save()
            print("✅ Demo thoughts loaded successfully")
        } catch {
            print("❌ Error saving demo thoughts: \(error)")
        }
    }
    
    // Clear all demo data
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
        
        // Therapist
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
        
        // Life Coach
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
        
        // Friend
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
        
        // Mentor
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
        
        // Spiritual Advisor (inactive)
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
        
        // Recent session with therapist
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
        
        // Session with life coach
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
        
        // Coffee chat with friend
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
        
        // Mentor meeting
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
        
        // Older therapy session
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
        // Goal 1
        let treatment1 = Treatment(context: context)
        treatment1.diagnosis = "Personal Growth"
        treatment1.goal = "Practice mindfulness daily"
        treatment1.desc = "Meditate for 10 minutes each morning. Track progress and notice improvements in stress levels."
        
        // Goal 2
        let treatment2 = Treatment(context: context)
        treatment2.diagnosis = "Career Development"
        treatment2.goal = "Complete career transition by end of year"
        treatment2.desc = "Update resume, network with professionals in target field, apply to 5 positions per week."
        
        // Goal 3
        let treatment3 = Treatment(context: context)
        treatment3.diagnosis = "Social Connection"
        treatment3.goal = "Strengthen relationships"
        treatment3.desc = "Reach out to friends and family weekly. Schedule regular catch-ups. Be more present in conversations."
        
        // Goal 4
        let treatment4 = Treatment(context: context)
        treatment4.diagnosis = "Mental Health"
        treatment4.goal = "Manage anxiety effectively"
        treatment4.desc = "Use breathing techniques when feeling anxious. Challenge negative thoughts. Maintain therapy schedule."
    }
    
    private static func createDemoThoughts(context: NSManagedObjectContext) {
        let calendar = Calendar.current
        let today = Date()
        
        // Recent thought
        let thought1 = Thought(context: context)
        thought1.content = "Feeling grateful today. The conversation with Alex really helped me put things in perspective. Sometimes I forget that everyone struggles, not just me."
        thought1.diagnosis = "Gratitude"
        
        // Anxious thought
        let thought2 = Thought(context: context)
        thought2.content = "Worried about the presentation next week. What if I mess up? But Dr. Johnson's advice about breaking it into smaller tasks is helping. I can do this."
        thought2.diagnosis = "Anxiety"
        
        // Reflective thought
        let thought3 = Thought(context: context)
        thought3.content = "Looking back at my sessions, I can see real progress. Three months ago I couldn't imagine making this career change. Now I have a plan and I'm taking action."
        thought3.diagnosis = "Reflection"
        
        // Motivational thought
        let thought4 = Thought(context: context)
        thought4.content = "Marcus said something that stuck with me: 'You don't have to be perfect, you just have to start.' Going to remember that when I feel stuck."
        thought4.diagnosis = "Motivation"
        
        // Processing thought
        let thought5 = Thought(context: context)
        thought5.content = "Change is hard. But it's also necessary. I'm learning to be okay with not having all the answers right now."
        thought5.diagnosis = "Processing"
    }
}

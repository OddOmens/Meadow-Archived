import SwiftUI

struct VersionView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section {
                    Text("Release 2025.12.1")
                        .font(.headline)
                    Text("Release Date: December 2025")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("""
                        • Updated the "Request a Feature" link
                        • Updated the "Report a Issue" link
                        • Updated the "Documentation" link
                        """).font(.caption)
                }
                
                Divider()
                
                Section {
                    Text("2025.11.1")
                        .font(.headline)
                    Text("Release Date: October 2025")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                    DEVELOPER NOTE: Brought Meadow back from the archive with a full revamp. Meadow is no longer just for therapy users, but anyone looking to capture the details of important growth conversations.
                    
                    • Added support for iOS26 and Liquid Glass
                    • Added Supporters Tab
                    • Added supported to Sessions
                    • Added relations to Thoughts
                    • Added tabs to easily swipe
                    • Added animations to the app
                    • Updated review prompts to 2nd and 5th launches
                    • Renamed "Sessions" to "Chats"
                    • Renamed "Profile" to "Myself"
                    • Fixed so many bugs
                    """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.2.3")
                        .font(.headline)
                    Text("Release Date: December 30th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                    • Updated report bug link
                    • Updated request feature link
                    """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.2.2")
                        .font(.headline)
                    Text("Release Date: December 17, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Added scroll to sessions, allowing you to see and write longer notes
                        • Fixed not being able to see session notes
                        • Fixed bug where users without name filled in, addding diagnosis crashes app (again?)
                        • Updated some deprecated code
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.2.1")
                        .font(.headline)
                    Text("Release Date: December 5, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Added "Burnout" as new diagnosis
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.2.0")
                        .font(.headline)
                    Text("Release Date: November 29, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Added eight (8) new diagnosis
                        • Updated Navigation flow
                        • Fixed bug where users without name filled in, addding diagnosis crashes app
                        • Fixed image path for 'Help Center'
                        • Fixed App Icon selection icon preview
                        • Fixed Navigation when you are in a new page
                        • Fixed Dark Theme toggle
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.1.0")
                        .font(.headline)
                    Text("Release Date: September 13, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Added support for iOS 18
                        • Added help center link
                        • Updated Privacy and Terms links to new website
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.0.2")
                        .font(.headline)
                    Text("Release Date: August 5th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Updated Term of Service is now hosted outside the app.
                        • Updated Privacy Policy is now hosted outside the app.
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.0.1")
                        .font(.headline)
                    Text("Release Date: July 15th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Fixed Apps section
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 2.0.0")
                        .font(.headline)
                    Text("Release Date: June 13th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Added option to turn off navigation labels
                        • Added ten custom app icons to use
                        • Added auto save to "Sessions"
                        • Added auto save to "Treatment Goals"
                        • Added auto save to "Thoughts"
                        • Added auto save to "Personal Information"
                        • Updated UI to be more modern and simple
                        • Updated all icons to be consistent with other apps
                        • Fixed major bug with iCloud and adding Diagnosis
                        • Fixed "Delete All Data" button in settings
                        • Fixed label from "Theme" to "Dark Theme"
                        • General changes and fixes
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 1.1.1")
                        .font(.headline)
                    Text("Release Date: April 16th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Adjusted review prompt to show after 7th and 12th launch of the app
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 1.1.0")
                        .font(.headline)
                    Text("Release Date: April 16th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • Added Apple PrivacyInfo
                        • Added nine new diagnoses
                        • Added ability to remove diagnoses from the list by tapping the green checkmark
                        • Updated "More Apps" Section
                        • Removed duplicate "Settings" title
                        • Fixed dark theme toggle button
                        """).font(.caption)
                }
                
                Divider().padding()
                
                Section {
                    Text("Version 1.0.0")
                        .font(.headline)
                    Text("Release Date: March 8th, 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("""
                        • The Initial Release of Meadow, a therapy compainion app to make your session more oragnized and streamlined
                        """).font(.caption)
                }
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
        .navigationTitle("Version History")
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
}

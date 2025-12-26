import Foundation
import CoreData

extension Client {
    public var disordersArray: [Disorder] {
        (disorders as? Set<Disorder> ?? []).sorted { $0.name ?? "" < $1.name ?? "" }
    }
} 
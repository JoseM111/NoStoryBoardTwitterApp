import UIKit

/* CaseIterable:--?
   Types that conform to the CaseIterable protocol are typically
   enumerations without associated values. When using a CaseIterable
   type, you can access a collection of all of the type’s cases by
   using the type’s allCases property. */
enum ProfileFilterOptions: Int, CaseIterable {
    // Mapping each one of these cases to a particular collection view cell
    // All these cases will get a integer value
    case tweets
    case replies
    case likes

    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}
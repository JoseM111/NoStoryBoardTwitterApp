import UIKit
import Firebase

struct TweetService {

    // MARK: #Shared-instance
    static let shared = TweetService()

    // MARK: #Typealias
    typealias k = DictKeys
    typealias ErrorOrDBRef = (Error?, DatabaseReference) -> Void

    // MARK: _©API-Methods
    /**©------------------------------------------------------------------------------©*/
    func uploadTweet(caption: String, completion: @escaping ErrorOrDBRef) {
        let zero: Int = 0
        let timeInterval = Date.init()

        // We need this uid because to know which user is trying to
        // post a tweet and the way we can know that is by there `id`
        guard let uid = AUTH.currentUser?.uid else { return }

        let tweetDictVals: [String: Any] = [ k.TweetUIDKey : uid,
                                             k.TimestampKey : timeInterval.dateRightNow(),
                                             k.LikesKey : zero,
                                             k.RetweetsKey : zero,
                                             k.CaptionKey : caption ]

        // -->.childByAutoId():--? Will automatically create an id for our tweet
        REF_TWEET.childByAutoId().updateChildValues(tweetDictVals, withCompletionBlock: completion)
        }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS



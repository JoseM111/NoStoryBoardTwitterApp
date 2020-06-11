import UIKit
import Firebase

struct TweetService {

    // MARK: #Shared-instance
    static let shared = TweetService()

    // MARK: #Typealias
    typealias k = DictKeys
    typealias dbRefOrError = (DatabaseReference, Error?) -> Void

    // MARK: _©API-Methods
    /**©------------------------------------------------------------------------------©*/
    func uploadTweet(caption: String, completion: @escaping dbRefOrError) {
        let zero: Int = 0
        let timeInterval = Int(NSDate().timeIntervalSince1970)

        // We need this uid because to know which user is trying to
        // post a tweet and the way we can know that is by there `id`
        guard let uid = AUTH.currentUser?.uid else { return }

        let tweetDictVals: [String: Any] = [ k.TweetUIDKey : uid,
                                             k.TimestampKey : timeInterval,
                                             k.LikesKey : zero,
                                             k.RetweetsKey : zero ]


    }

    /**©------------------------------------------------------------------------------©*/
}

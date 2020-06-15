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
        let timeStamp = Date.init()

        // We need this uid because to know which user is trying to
        // post a tweet and the way we can know that is by there `id`
        guard let uid = AUTH.currentUser?.uid else { return }

        let tweetDictVals: [String: Any] = [ k.TweetUIDKey : uid,
                                             k.TimestampKey : timeStamp.dateRightNow(),
                                             k.LikesKey : zero,
                                             k.RetweetsKey : zero,
                                             k.CaptionKey : caption ]

        // -->.childByAutoId():--? Will automatically create an id for our tweet
        REF_TWEET.childByAutoId().updateChildValues(tweetDictVals, withCompletionBlock: completion)
        }

    // MARK: - fetchTweets
    func fetchTweets(completion: @escaping ([Tweet]) -> Void) {
        // What we will append all our tweets too
        var addedTweets: [Tweet] = []

        // When ever a tweet is inputted it gets added instantly
        REF_TWEET.observe(.childAdded) { (snapShot) in
            guard let tweetsDict = snapShot.value as? [String : Any] else { return }
            let tweetID = snapShot.key
            let tweet = Tweet(tweetID: tweetID, dict: tweetsDict)

            // Append the new tweet
            addedTweets.append(tweet)
            completion(addedTweets)
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS



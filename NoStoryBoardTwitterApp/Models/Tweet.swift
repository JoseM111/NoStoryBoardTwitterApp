import UIKit

struct Tweet {
    // MARK: #©Typealias-DictKeys
    typealias k = DictKeys

    // MARK: _©Properties
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    var timeStamp: Date?
    let retweetCount: Int

    let user: User

    init(user: User, tweetID: String, dict: [String : Any]) {
        self.tweetID = tweetID
        self.user = user

        self.caption = dict[k.CaptionKey] as? String ?? ""
        self.uid = dict[k.TweetUIDKey] as? String ?? ""
        self.likes = dict[k.LikesKey] as? Int ?? 0
        self.retweetCount = dict[k.RetweetsKey] as? Int ?? 0

        if let timeStamp = dict[k.TimestampKey] as? Double {
            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
        }
    }
}


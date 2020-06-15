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

    init(tweetID: String, dict: [String : Any]) {
        self.tweetID = tweetID

        self.caption = dict[k.CaptionKey] as? String ?? ""
        self.uid = dict[k.TUIDKey] as? String ?? ""
        self.likes = dict[k.LikesKey] as? Int ?? 0
        self.retweetCount = dict[k.RetweetsKey] as? Int ?? 0
        self.timeStamp = dict[k.TimestampKey] as? Date ?? Date()
    }
}


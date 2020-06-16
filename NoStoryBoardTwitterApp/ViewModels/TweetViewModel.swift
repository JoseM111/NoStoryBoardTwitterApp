import UIKit

struct TweetViewModel {
    // MARK: _©Properties
    let tweet: Tweet
    let user: User

    var profileImgURL: URL? {
        user.profileImgURL
    }

    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        /*  Can render the time since tweet in the format time inside the array */
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]//<-- Since tweet posted
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated

        let now = Date()
        return formatter.string(from: tweet.timeStamp ?? Date(), to: now) ?? ""
    }

    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname,
                                              attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])

        // Adds the @userWhatever in the cell of the tweet
        title.append(NSAttributedString(string: " @\(user.username)",
                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))
        // Adds the `timestamp` in the cell of the tweet
        title.append(NSAttributedString(string: " ∙ \(timeStamp)",
                                        attributes: [.font: UIFont.boldSystemFont(ofSize: 14),
                                                     .foregroundColor: UIColor.lightGray]))


        return title
    }

    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}

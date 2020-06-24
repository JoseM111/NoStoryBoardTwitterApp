import UIKit
import Firebase

struct User {
    // MARK: #©Typealias-DictKeys
    typealias k = DictKeys

    // MARK: _©Properties
    let fullname: String
    let email: String
    let pwd: String
    let username: String
    var profileImgURL: URL?
    let uid: String

    var isFollowed: Bool = false
    var stats: UserRelationsStats?

    // MARK: $Helper computed property to figure out current user
    var isCurrentUser: Bool { AUTH.currentUser?.uid == uid }

    init(uid: String, dict: [String : AnyObject]) {
        self.uid = uid

        self.fullname = dict[k.FullNameKey] as? String ?? ""
        self.email = dict[k.EmailKey] as? String ?? ""
        self.pwd = dict[k.PWDKey] as? String ?? ""
        self.username = dict[k.UserKey] as? String ?? ""

        if let profileImgUrlStr: String = dict[k.ImgUrlKey] as? String {
            guard let imgURL: URL = URL(string: profileImgUrlStr) else { return }
            self.profileImgURL = imgURL
        }
    }
}

// MARK: #©Helper Object
struct UserRelationsStats {
    // MARK: _©Properties
    var followers: Int
    var following: Int
}

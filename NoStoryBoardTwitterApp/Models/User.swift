import UIKit

struct User {
    // MARK: #©Typealias-DictKeys
    typealias k = DictKeys

    // MARK: _©Properties
    let fullname: String
    let email: String
    let pwd: String
    let username: String
    let profileImgURL: String
    let uid: String

    init(uid: String, dict: [String : AnyObject]) {
        self.uid = uid

        self.fullname = dict[k.FullNameKey] as? String ?? ""
        self.email = dict[k.EmailKey] as? String ?? ""
        self.pwd = dict[k.PWDKey] as? String ?? ""
        self.username = dict[k.UserKey] as? String ?? ""
        self.profileImgURL = dict[k.ImgUrlKey] as? String ?? ""
    }
}

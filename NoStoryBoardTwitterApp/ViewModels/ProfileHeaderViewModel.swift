import UIKit

struct ProfileHeaderViewModel {
    // MARK: _$typealiases
    typealias NSAttrStr = NSAttributedString
    typealias NSMutAttrStr = NSMutableAttributedString

    // MARK: _©Properties
    internal let user: User

    internal let usernameText: String

    internal var followersStr: NSAttrStr? {
        attrTextWith(value: 0, text: " Followers")
    }

    internal var followingStr: NSAttrStr? {
        attrTextWith(value: 2, text: " Following")
    }

    internal var actionBtnTitle: String {
        // If user is current user, then set to edit profile
        // Else figure out following/ not following
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return "Follow"
        }
    }

    init(user: User) {
        self.user = user
        self.usernameText = "@\(user.username)"
    }
    
    // Helper function
    fileprivate func attrTextWith(value: Int, text: String) -> NSAttrStr {
        let boldSystemFont: UIFont = UIFont.boldSystemFont(ofSize: 14)
        let regSystemFont: UIFont = UIFont.systemFont(ofSize: 14)
        let lightGray: UIColor = UIColor.lightGray

        let attrTitle = NSMutAttrStr(string: "\(value)", attributes: [ .font : boldSystemFont ])
        attrTitle.append(NSAttrStr(string: "\(text)", attributes: [ .font : regSystemFont, .foregroundColor :  lightGray ]))
        return attrTitle
    }
}
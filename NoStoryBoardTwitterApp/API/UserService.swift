import UIKit
import Firebase

struct UserService {
    // MARK: #©Shared-instance
    static let shared = UserService()
    // MARK: #©Type-alias DictKeys
    typealias k = DictKeys

    // MARK: _©API-Methods
    /**©------------------------------------------------------------------------------©*/
    func fetchUser(uid: String, completion: @escaping (User) -> Void) {

        DATABASE_REF_CHILD.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            // Our User dictionary
            guard let snapshotDict: [String: AnyObject] = snapshot.value
                    as? [String : AnyObject] else { return }

            let user = User(uid: uid, dict: snapshotDict)
            completion(user)
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS

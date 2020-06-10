import UIKit
import Firebase

struct UserService {
    // MARK: #©Shared-instance
    static let shared = UserService()
    // MARK: #©Type-alias DictKeys
    typealias k = DictKeys

    func fetchUser(completion: @escaping (User) -> Void) {

        guard let uid = AUTH.currentUser?.uid else { return }

        DATABASE_REF_CHILD.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            // Our User dictionary
            guard let snapshotDict: [String: AnyObject] = snapshot.value
                    as? [String : AnyObject] else { return }

            let user = User(uid: uid, dict: snapshotDict)
            completion(user)
        }
    }
}

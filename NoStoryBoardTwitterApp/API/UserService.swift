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

        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            // Our User dictionary
            guard let snapshotDict: [String: AnyObject] = snapshot.value
                    as? [String : AnyObject] else { return }

            let user = User(uid: uid, dict: snapshotDict)
            completion(user)
        }
    }

    func fetchListOfUsers(completion: @escaping ([User]) -> Void) {
        // Empty users array to append users
        var listOfUsers = [User]()

        REF_USERS.observe(.childAdded) { snapShot in
            // Creating a key
            let uid = snapShot.key
            // Dictionary of cell keys/values
            guard let cellDict = snapShot.value as? [ String : AnyObject ] else { return }

            // Create a user
            let user = User(uid: uid, dict: cellDict)
            // Append user
            listOfUsers.append(user)
            completion(listOfUsers)
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS

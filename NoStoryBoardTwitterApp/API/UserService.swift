import UIKit
import Firebase

struct UserService {
    // MARK: #©Shared-instance
    static let shared = UserService()
    // MARK: #©Type-alias DictKeys
    typealias k = DictKeys
    typealias ErrorOrDBRef = (Error?, DatabaseReference) -> Void

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

    func followUser(uid: String, completion: @escaping ErrorOrDBRef) {
        // __________
        guard let currentUID = AUTH.currentUser?.uid else { return }

        REF_USER_FOLLOWING.child(currentUID).updateChildValues([uid : 1]) { (error, _) in
            // __________
            if let error = error {
                return printf("""
                              [ERROR] Could not update data...
                              \(error.localizedDescription)
                              """)
            }

            REF_USER_FOLLOWERS.child(uid).updateChildValues([currentUID : 1], withCompletionBlock: completion)
        }
    }

    func unfollowUser(uid: String, completion: @escaping ErrorOrDBRef) {
        // __________
        guard let currentUID = AUTH.currentUser?.uid else { return }

        REF_USER_FOLLOWING.child(currentUID).child(uid).removeValue { (error, ref) in
            // __________
            if let error = error {
                return printf("""
                              [ERROR] Could not update data...
                              \(error.localizedDescription)
                              """)
            }

            REF_USER_FOLLOWERS.child(uid).child(currentUID).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping (Bool) -> Void) {
        // __________
        guard let currentUID = AUTH.currentUser?.uid else { return }

        REF_USER_FOLLOWING.child(currentUID).child(uid).observeSingleEvent(of: .value) { snapShot in
            printf("DEBUG: User is followed: \(snapShot.exists())")
            completion(snapShot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping (UserRelationsStats) -> Void) {
        // Will return the number of users following
        REF_USER_FOLLOWERS.child(uid).observeSingleEvent(of: .value) { snapShot in
            let followers = snapShot.children.allObjects.count

            REF_USER_FOLLOWING.child(uid).observeSingleEvent(of: .value) { snapShot in
                let following = snapShot.children.allObjects.count

                let stats = UserRelationsStats(followers: followers, following: following)
                completion(stats)
            }
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS

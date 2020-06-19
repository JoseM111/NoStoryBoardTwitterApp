import UIKit
import Firebase

struct AuthService {
    // MARK: #©Shared-instance
    static let shared = AuthService()

    // MARK: _©Utilities-typealias
    typealias k = DictKeys
    typealias ErrorOrDBRef = (Error?, DatabaseReference) -> Void

    // MARK: _©API-methods
    /**©------------------------------------------------------------------------------©*/

    // MARK: #©loginUser
    func loginUserWith(email: String, pwd: String, completion: AuthDataResultCallback?) {
        AUTH.signIn(withEmail: email, password: pwd, completion: completion)
        printf("""
               Email: \(email)
               Password: \(pwd)
               """)
    }

    // MARK: #©registerUser
    func registerUser(credentials c: AuthCredentials, completion: @escaping ErrorOrDBRef) {
        let email: String = c.email
        let pwd: String = c.pwd
        let username: String = c.username
        let fullname: String = c.fullname

        guard let imgData: Data = c.profileImg.jpegData(compressionQuality: 0.3) else { return }

        printf("Right after assigning all field variables...")
        // Once we obtain the image, we want to compress it. Because the
        // image will be to large & will take longer to upload to firebase.
        let filenameID = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filenameID)

        printf("Made it to--> putData()...")
        // MARK: _©Uploading the image data to firebase
        storageRef.putData(_: imgData, metadata: nil) { (_ , _) in

            // MARK: _©storageRef.downloadURL
            storageRef.downloadURL { url, error in
                guard let profileImgURL = url?.absoluteString else { return }

                // MARK: _©Firebase-createUser
                printf("Got to create user--> createUser()...")
                AUTH.createUser(withEmail: email, password: pwd) { (result, error) in
                    // - Handling error
                    if let error = error {
                        return printf("DEBUG: Error is \(error.localizedDescription)")
                    }

                    // - User ID
                    guard let uid = result?.user.uid else { return }

                    // Data Dictionary
                    let dictData: [String: Any] = [ k.UserIDKey : uid, k.EmailKey : email,
                                                    k.PWDKey : pwd, k.UserKey : username,
                                                    k.FullNameKey : fullname,
                                                    k.ImgUrlKey : profileImgURL ]

                    // Updating database
                    printf("Reached database call--> .updateChildValues(dictData)...")
                    REF_USERS.child(uid).updateChildValues(dictData, withCompletionBlock: completion)

                    printf("""
                           DEBUG: User ID: \(uid)
                           DEBUG: Email: \(email)
                           DEBUG: Password: \(pwd)
                           DEBUG: Full Name: \(fullname)
                           DEBUG: User Name: \(username)
                           DEBUG: User Name: \(profileImgURL)
                           """)
                }
            }
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS

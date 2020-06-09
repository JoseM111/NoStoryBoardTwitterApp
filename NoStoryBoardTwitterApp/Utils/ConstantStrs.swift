import UIKit
import Firebase

// Uploads image to firebase
let STORAGE_REF: StorageReference = Storage.storage().reference()
let PROFILE_IMG: String = "profile_images"
let STORAGE_PROFILE_IMAGES: StorageReference = STORAGE_REF.child(PROFILE_IMG)

// Create user to firebase
let AUTH: Auth = Auth.auth()
let USERS: String = "users"
let DATABASE_REF_CHILD: DatabaseReference = Database.database().reference().child(USERS)
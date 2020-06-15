import UIKit
import Firebase

// UPLOADS IMAGE TO FIREBASE
let STORAGE_REF: StorageReference = Storage.storage().reference()
let PROFILE_IMG: String = "profile_images"
let STORAGE_PROFILE_IMAGES: StorageReference = STORAGE_REF.child(PROFILE_IMG)

// CREATE USER TO FIREBASE
let AUTH: Auth = Auth.auth()
let USERS: String = "users"
let DATABASE_REF_CHILD: DatabaseReference = Database.database().reference().child(USERS)

// TWEET CONSTANTS
let TWEET: String = "tweet"
let REF_TWEET: DatabaseReference = DATABASE_REF_CHILD.child(TWEET)

let REUSE_IDENTIFIER = "TweetCell"
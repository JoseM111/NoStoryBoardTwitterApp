import UIKit
import Firebase

// UPLOADS IMAGE TO FIREBASE
let STORAGE_REF: StorageReference = Storage.storage().reference()
let PROFILE_IMG: String = "profile_images"
let STORAGE_PROFILE_IMAGES: StorageReference = STORAGE_REF.child(PROFILE_IMG)

// CREATE USER TO FIREBASE
let AUTH: Auth = Auth.auth()
let USERS: String = "users"
let DB_REF: DatabaseReference = Database.database().reference()
let REF_USERS: DatabaseReference = DB_REF.child(USERS)
let USERFOLLOWING: String = "user-following"
let USERFOLLOWERS: String = "user-followers"
let REF_USER_FOLLOWING: DatabaseReference = DB_REF.child(USERFOLLOWING)
let REF_USER_FOLLOWERS: DatabaseReference = DB_REF.child(USERFOLLOWERS)

// TWEET CONSTANTS
let TWEET: String = "tweet"
let REF_TWEET: DatabaseReference = REF_USERS.child(TWEET)
let USERTWEETS: String = "user-tweets"
let REF_USER_TWEETS: DatabaseReference = REF_USERS.child(USERTWEETS)

// REUSABLE-CELL
let TWEET_IDENTIFIER: String = "TweetCell"
let PROFILE_HEADER_IDENTIFIER: String = "ProfileHeader"
let PROFILE_FILTER_IDENTIFIER: String = "ProfileFilterCell"
let USER_IDENTIFIER: String = "UserCell"
let TWEET_HEADER_IDENTIFIER: String = "TweetHeader"

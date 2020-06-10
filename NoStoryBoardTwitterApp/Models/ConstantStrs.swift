import UIKit
import Firebase

let AUTH: Auth = Auth.auth()
let USERS: String = "users"
let DATABASE_REF_CHILD: DatabaseReference = Database.database().reference().child(USERS)
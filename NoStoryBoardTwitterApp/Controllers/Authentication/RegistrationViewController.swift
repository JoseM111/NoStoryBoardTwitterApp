import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    // MARK: _©Utilities-typealias
    typealias u = Utilities
    typealias k = DictKeys

    // MARK: -#©Image-picker property
    internal let imgPicker = UIImagePickerController()
    internal var profileImg: UIImage?

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/

    // MARK: -#©twitterLogoImgView
    internal let plusPhotoBtnImg: UIButton = {
        let plusPhotoBtn = UIButton(type: .system)
        plusPhotoBtn.setImage(UIImage(named: "plus_photo"), for: .normal)

        // Gives the button a white color
        plusPhotoBtn.tintColor = .white
        plusPhotoBtn.addTarget(self, action: #selector(handleProfilePhoto), for: .touchUpInside)

        return plusPhotoBtn
    }()

    // MARK: _©Container-views-with-properties
    /**©-----------------------©*/
    internal lazy var emailContainerView: UIView = {
        let uiView = UIView()
        let uiImgView = UIImageView()
        let mailImg: String = "ic_mail_outline_white_2x-1"

        let containerView: UIView = u.inputContainerViewWith(
                uiView: uiView, uiImgView: uiImgView, named: mailImg,
                anchorPaddingLeft: 8, anchorPaddingBottom: 8,
                dimensionWidth: 24, dimensionHeight: 24, txtField: emailTxtField)

        return containerView
    }()

    internal lazy var pwdContainerView: UIView = {
        let uiView = UIView()
        let uiImgView = UIImageView()
        let lockImg: String = "ic_lock_outline_white_2x"

        let containerView: UIView = u.inputContainerViewWith(
                uiView: uiView, uiImgView: uiImgView, named: lockImg,
                anchorPaddingLeft: 8, anchorPaddingBottom: 8,
                dimensionWidth: 24, dimensionHeight: 24, txtField: pwdTxtField)

        return containerView
    }()

    internal lazy var fullNameContainerView: UIView = {
        let uiView = UIView()
        let uiImgView = UIImageView()
        let mailImg: String = "ic_person_outline_white_2x"

        let containerView: UIView = u.inputContainerViewWith(
                uiView: uiView, uiImgView: uiImgView, named: mailImg,
                anchorPaddingLeft: 8, anchorPaddingBottom: 8,
                dimensionWidth: 24, dimensionHeight: 24, txtField: fullNameTxtField)

        return containerView
    }()

    internal lazy var usernameContainerView: UIView = {
        let uiView = UIView()
        let uiImgView = UIImageView()
        let lockImg: String = "ic_person_outline_white_2x"

        let containerView: UIView = u.inputContainerViewWith(
                uiView: uiView, uiImgView: uiImgView, named: lockImg,
                anchorPaddingLeft: 8, anchorPaddingBottom: 8,
                dimensionWidth: 24, dimensionHeight: 24, txtField: usernameTxtField)

        return containerView
    }()


    /**© END ©Container views with properties ©*/

    // MARK: _©Text-fields
    /**©-----------------------©*/
    internal let emailTxtField: UITextField = {
        let email: String = "Email"
        let tf: UITextField = u.textFieldWith(placeHolder: email, fontSize: 16)
        return tf
    }()

    internal let pwdTxtField: UITextField = {
        let pwd: String = "Password"
        let tf: UITextField = u.textFieldWith(placeHolder: pwd, fontSize: 16)

        /* Adding this line of code to secure the text entry. Meaning the
           password text will look like --> ....... when typed
           [NOTE] CMD + K pops up and dismisses the keyboard on the simulator */
        tf.isSecureTextEntry = true
        return tf
    }()

    internal let fullNameTxtField: UITextField = {
        let fullName: String = "Full Name"
        let tf: UITextField = u.textFieldWith(placeHolder: fullName, fontSize: 16)
        return tf
    }()

    internal let usernameTxtField: UITextField = {
        let username: String = "User Name"
        let tf: UITextField = u.textFieldWith(placeHolder: username, fontSize: 16)
        return tf
    }()

    // MARK: #©Login-button
    internal let registrationBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)

        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 5

        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return btn
    }()

    // MARK: #©dontHaveAccBtn
    internal var alreadyHaveAccBtn: UIButton = {
        let haveAccount: String = "Already have account?"
        let logIn: String = " Log In"
        let btn: UIButton = u.attrButton(haveAccount, logIn)

        btn.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return btn
    }()
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    /**©-----------------------©*/

    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func handleRegistration() {

        guard let profileImg: UIImage = profileImg else {
            return printf("DEBUG: Please select a profile image...")
        }
        guard let email: String = emailTxtField.text,
              let pwd: String = pwdTxtField.text,
              let fullname: String = fullNameTxtField.text,
              let username: String = usernameTxtField.text else { return }

        // Once we obtain the image, we want to compress it. Because the
        // image will be to large & will take longer to upload to firebase.
        guard let imgData = profileImg.jpegData(compressionQuality: 0.3) else { return }
        let filenameID = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filenameID)

        // MARK: _©Uploading the image data to firebase
        storageRef.putData(_: imgData, metadata: nil) { (meta , error) in
            // - Handling error
            if let error = error {
                return printf("[ERROR] No data found..\n\(error.localizedDescription)")
            }

            storageRef.downloadURL { url, error in
                guard let profileImgURL = url?.absoluteString else { return }

                // MARK: _©Firebase-createUser
                /**©-----------------------©*/
                AUTH.createUser(withEmail: email, password: pwd) { (result, error) in
                    // - Handling error
                    if let error = error {
                        return printf("DEBUG: Error is \(error.localizedDescription)")
                    }

                    // - User ID
                    guard let uid = result?.user.uid else { return }

                    // Data Dictionary
                    let dictData = [ k.UIDKey : uid, k.EmailKey : email,
                                     k.PWDKey : pwd, k.UserKey : username,
                                     k.FullNameKey : fullname,
                                     k.ImgUrlKey : profileImgURL ]

                    // Updating
                    DATABASE_REF_CHILD.child(uid).updateChildValues(dictData) { (error, _) in
                        if let error = error {
                            return printf("[ERROR] Could not add user to firebase..\n\(error.localizedDescription)")
                        }

                        printf("DEBUG: Successfully registered user...")
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
                /**©-----------------------©*/
            }
        }
    }/// END OF FUNCTION

    @objc func handleProfilePhoto() {
        present(imgPicker, animated: true, completion: nil)
        printf("Add photo...")
    }

    @objc func handleShowLogin() {
        // This code shows the login controller
        /*-------------------------------------------------------
          Since the registration controller is on top of the stack,
          of controllers, when the `alreadyHaveAccBtn` is pressed,
          the registration controller will be popped off the top
          of the stack and the top view controller will be the
          login controller again, which was under on the stack,
          of the registration controller
          -------------------------------------------------------*/
        navigationController?.popViewController(animated: true)
        printf("Forwarded back to the login controller...")

    }
    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        view.backgroundColor = .twitterBlue

        // MARK: _©Setting-imagePickers-->Delegate
        /**©-----------------------©*/
        imgPicker.delegate = self
        imgPicker.allowsEditing = true
        /**©-----------------------©*/

        // MARK: _©twitterLogoImgView
        /**©-----------------------©*/
        // Setting up our logo
        view.addSubview(plusPhotoBtnImg)
        // Constraining our logo
        plusPhotoBtnImg.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        // Setting the height & width of the logo
        plusPhotoBtnImg.setDimensions(width: 105, height: 105)
        /**©-----------------------©*/

        // MARK: _©Vertical-stack-view
        // Creating a stack view with some helper functions
        /**©-------------------------------------------©*/
        let verticalStack = UIStackView(
                arrangedSubviews: [
                    emailContainerView, pwdContainerView, fullNameContainerView,
                    usernameContainerView, registrationBtn ])

        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        /* .distribution:--? This property determines how the
            stack view lays out its arranged views along its axis. */
        verticalStack.distribution = .fillEqually

        view.addSubview(verticalStack)
        verticalStack.anchorWith(top: plusPhotoBtnImg.bottomAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        /**©-------------------------------------------©*/


        // MARK: #©Anchoring our--> dontHaveAccBtn to the bottom of the screen
        view.addSubview(alreadyHaveAccBtn)
        alreadyHaveAccBtn.anchorWith(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }

    /**©-------------------------------------------©*/
}// END OF CLASS

// MARK: _©extension|RegistrationViewController|:[ UIImagePickerControllerDelegate, UINavigationControllerDelegate ]
extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: -#© imagePickerController
    /* Tells the delegate that the user picked a still image or movie.
       and allows the user to use the selected media. */
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

        // MARK: _©Adjusting-Image-Look
        // Adding a corner radius to the image we
        // select To render it nice and rounded
        /**©-----------------------©*/
        plusPhotoBtnImg.layer.cornerRadius = 105 / 2
        plusPhotoBtnImg.layer.masksToBounds = true
        // Scales the image to fit the frame
        plusPhotoBtnImg.imageView?.contentMode = .scaleAspectFill
        // A Boolean value that determines whether subviews are confined to the bounds of the view.
        plusPhotoBtnImg.imageView?.clipsToBounds = true
        // Adding our border-color: NOTE you must add the .cgColor for it to work
        plusPhotoBtnImg.layer.borderColor = UIColor.white.cgColor
        // Adding the border width
        plusPhotoBtnImg.layer.borderWidth = 3
        /**©-----------------------©*/

        // info[.editedImage]:--? is a dictionary[ info/key : .editedImage/value ]
        /* .withRenderingMode:--? Returns a new version of the image configured with the specified rendering mode.
           .alwaysOriginal:--? Always draw the original image, without treating it as a template. */
        guard let profileImg: UIImage = info[.editedImage] as? UIImage else { return }
        self.profileImg = profileImg

        self.plusPhotoBtnImg.setImage(profileImg.withRenderingMode(.alwaysOriginal), for: .normal)
        // Have to dismiss the image picker or when you choose in the simulator nothing happens
        dismiss(animated: true, completion: nil)
    }
}
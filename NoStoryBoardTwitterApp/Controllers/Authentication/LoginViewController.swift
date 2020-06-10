import UIKit

class LoginViewController: UIViewController {

    // MARK: _©Utilities-typealias
    typealias u = Utilities

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/

    // MARK: -#©twitterLogoImgView
    internal let twitterLogoImgView: UIImageView = {
        let twitterImg = UIImageView()
        twitterImg.contentMode = .scaleAspectFit
        /* .clipsToBounds:--? A Boolean value that determines
           whether subviews are confined to the bounds of the view. */
        twitterImg.clipsToBounds = true
        twitterImg.image = UIImage(named: "TwitterLogo")
        return twitterImg
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

    /**© END ©Text views ©*/

    // MARK: #©Login-button
    internal let loginBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log in", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)

        btn.backgroundColor = .white
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.layer.cornerRadius = 5

        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()

    // MARK: #©dontHaveAccBtn
    internal var dontHaveAccBtn: UIButton = {
        let dontHaveAcc: String = "Dont have account?"
        let signUp: String = " Sign Up"
        let btn: UIButton = u.attrButton(dontHaveAcc, signUp)

        btn.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
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
    @objc func handleShowSignUp() {
        let registrationVC = RegistrationViewController()
        navigationController?.pushViewController(registrationVC, animated: true)
        printf("Show sign up...")
    }

    @objc func handleLogin() {
        guard let email: String = emailTxtField.text,
              let pwd: String = pwdTxtField.text else { return }

        AuthService.shared.loginUserWith(email: email, pwd: pwd) {(_, error) in
            if let error = error {
                return printf("Error logging in...\n\(error.localizedDescription)")
            }

            // Accessing our main tab controller:
            // We have to create our window because `keyWindow` is deprecated since ios 13 came out
            guard let window: UIWindow = UIApplication.shared.windows
                    .first(where: { $0.isKeyWindow }) else { return }

            guard let mainTab: MainTabController = window.rootViewController as? MainTabController else { return }
            // Now when you log in successfully, you should be forwarded to your main tab controller
            mainTab.authUserAndConfigUI()

            self.dismiss(animated: true, completion: nil)
            printf("DEBUG: Successful login...")
        }

    }
    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        view.backgroundColor = .twitterBlue

        /* navigationController?.navigationBar.barStyle = .black
           Makes the status bar(Time->Battery-life) white
           Though you are calling .black the text color
           is going to render white. This works In the
           Navigation controller only, since its embedded
           in one. If you wanted to do it for the controller
           itself you would use:
           -----------------------------------------------------
           var preferredStatusBarStyle: UIStatusBarStyle { get }
           which is for the following:
           -----------------------------------------------------
           The preferred status bar style for the view controller */
        navigationController?.navigationBar.barStyle = .black
        // Hides the navigation controller
        navigationController?.navigationBar.isHidden = true

        // MARK: _©twitterLogoImgView
        /**©-----------------------©*/
        // Setting up our logo
        view.addSubview(twitterLogoImgView)
        // Constraining our logo
        twitterLogoImgView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        // Setting the height & width of the logo
        twitterLogoImgView.setDimensions(width: 105, height: 105)
        /**©-----------------------©*/

        // MARK: _©Vertical-stack-view
        // Creating a stack view with some helper functions
        /**©-------------------------------------------©*/
        let verticalStack = UIStackView(
                arrangedSubviews: [ emailContainerView, pwdContainerView, loginBtn ])
        verticalStack.axis = .vertical
        verticalStack.spacing = 20
        /* .distribution:--? This property determines how the
            stack view lays out its arranged views along its axis. */
        verticalStack.distribution = .fillEqually

        view.addSubview(verticalStack)
        verticalStack.anchorWith(top: twitterLogoImgView.bottomAnchor, left: view.leftAnchor,
                                 right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        /**©-------------------------------------------©*/

        // MARK: #©Anchoring our--> dontHaveAccBtn to the bottom of the screen
        view.addSubview(dontHaveAccBtn)
        dontHaveAccBtn.anchorWith(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                  right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
    /**©-------------------------------------------©*/
}






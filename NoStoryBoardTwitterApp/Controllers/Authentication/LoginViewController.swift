import UIKit

class LoginViewController: UIViewController {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
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

        let containerView: UIView = Utilities.inputContainerViewWith(
                uiView: uiView, uiImgView: uiImgView, named: mailImg,
                anchorPaddingLeft: 8, anchorPaddingBottom: 8,
                dimensionWidth: 24, dimensionHeight: 24, txtField: emailTxtField)

        return containerView
    }()

    internal lazy var pwdContainerView: UIView = {
        let uiView = UIView()
        let uiImgView = UIImageView()
        let lockImg: String = "ic_lock_outline_white_2x"

        let containerView: UIView = Utilities.inputContainerViewWith(
                uiView: uiView, uiImgView: uiImgView, named: lockImg,
                anchorPaddingLeft: 8, anchorPaddingBottom: 8,
                dimensionWidth: 24, dimensionHeight: 24, txtField: pwdTxtField)

        return containerView
    }()
    /**© END ©Container views with properties ©*/

    // MARK: _©Text-views
    /**©-----------------------©*/
    internal let emailTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email..."


        return tf
    }()

    internal let pwdTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password..."


        return tf
    }()

    /**© END ©Text views ©*/

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

        // Setting up our logo
        view.addSubview(twitterLogoImgView)
        // Constraining our logo
        twitterLogoImgView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        // Setting the height & width of the logo
        twitterLogoImgView.setDimensions(width: 150, height: 150)

        // Creating a stack view with some helper functions
        let verticalStack = UIStackView(arrangedSubviews: [ emailContainerView, pwdContainerView ])
        verticalStack.axis = .vertical
        verticalStack.spacing = 8

        view.addSubview(verticalStack)
        verticalStack.anchorWith(top: twitterLogoImgView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
    }

    /**©-------------------------------------------©*/
}






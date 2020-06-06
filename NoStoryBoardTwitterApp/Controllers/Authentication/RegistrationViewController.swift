import UIKit

class RegistrationViewController: UIViewController {

    // MARK: _©Utilities-typealias
    typealias u = Utilities

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
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

        // MARK: #©Anchoring our--> dontHaveAccBtn to the bottom of the screen
        view.addSubview(alreadyHaveAccBtn)
        alreadyHaveAccBtn.anchorWith(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                     right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }

    /**©-------------------------------------------©*/
}
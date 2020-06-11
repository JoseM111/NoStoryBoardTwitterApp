import UIKit

class UploadTweetViewController: UIViewController {

    internal let user: User

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // Def--> lazy: Only load the actionBtn, when its called upon.
    internal lazy var actionBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)

        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)

        // Setting the button constraints and size with rounded edges
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        // Dividing the height by 2 to get the correct corner radius
        btn.layer.cornerRadius = 32 / 2

        btn.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)

        return btn
    }()

    // -->profileImgView
    internal let profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        // How big the image view will be
        iv.setDimensions(width: 52, height: 52)
        
        // width/Height = 48 which will give us a full circle if divided
        // by 2. This only works when the width & the height are the same.
        iv.layer.cornerRadius = 52 / 2
        iv.backgroundColor = .twitterBlue

        return iv
    }()

    // --> captionTxtView
    internal let captionTxtView = CaptionTxtView()
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    /* Custom initializer to use the image we already fetched, inside of the
    UploadTweetViewController  so we do not have to fetch teh image multiple times */
    init(user fetchUserImgProp: User) {
        self.user = fetchUserImgProp
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        // Checking is its loading the right user
        printf("DEBUG: User: \(user.username)")
    }

    /**©-----------------------©*/

    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func handleUploadTweet() {
        printf("""
               DEBUG: Button clicked!..-->
               Uploading tweet...
               """)
    }

    @objc func handleCancel() {
        // Going to dismiss the presented view when clicked
        dismiss(animated: true, completion: nil)
        printf("""
               DEBUG: Button clicked!..--> 🦅
               Dismissing UploadTweetViewController...
               """)
    }
    /**©-------------------------------------------©*/

    // MARK: _##API'S
    /**©-------------------------------------------©*/

    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        view.backgroundColor = .white
        configureNavBar()

        // MARK: _#Creating a horizontal stack view
        /**©-------------------------------------------©*/
        let hStack = UIStackView(arrangedSubviews: [ profileImgView, captionTxtView ])
        hStack.axis = .horizontal
        hStack.spacing = 12

        // MARK: _#©profileImgView
        view.addSubview(hStack)
        hStack.anchorWith(
                top: view.safeAreaLayoutGuide.topAnchor,
                left: view.leftAnchor, right: view.rightAnchor,
                paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        /**©-------------------------------------------©*/

        // MARK: #©Fetching our profile image
        /* Its not fetching the image again but it is caching
           it so it does not fetch the same image multiple times. */
        profileImgView.sd_setImage(with: user.profileImgURL, completed: nil)

    }
    
    func configureNavBar() {
        /* Inside an extension of UIViewController:--?
           open var navigationController: UINavigationController? { get } . */
        navigationController?.navigationBar.barTintColor = .white
        // Def .isTranslucent: semi-transparent.
        navigationController?.navigationBar.isTranslucent = false

        // Top nav structure
        /**©-----------------------©*/
        // MARK: #©Cancel-button
        navigationItem.leftBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .cancel,
                target: self, action: #selector(handleCancel))

        // MARK: _#©Tweet-button
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionBtn)
        /**©-----------------------©*/
    }

    /**©-------------------------------------------©*/
}

import UIKit

class FeedViewController: UIViewController {

    // MARK: _©Computed-property
    var user: User? {
        didSet { printf("DEBUG: Did set user in feed controller...") }
    }

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/

    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    /**©-----------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        view.backgroundColor = .white

        // Setup our twitter logo at the top of the nav bar
        let twitterImgView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        // How the image is going to get fit inside of the image view
        twitterImgView.contentMode = .scaleAspectFit
        /* .titleView:--? A custom view displayed in the center of
            the navigation bar when the receiver is the top item. */
        navigationItem.titleView = twitterImgView

        let profileImgView = UIImageView()
        profileImgView.backgroundColor = .twitterBlue
        profileImgView.setDimensions(width: 32, height: 32)
        profileImgView.layer.cornerRadius = 32 / 2

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImgView)
    }

    /**©-------------------------------------------©*/
}

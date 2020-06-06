import UIKit

class FeedViewController: UIViewController {

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
    }

    /**©-------------------------------------------©*/
}

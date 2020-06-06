import UIKit

class MainTabController: UITabBarController {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    let actionBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor = .twitterBlue
        btn.setImage(UIImage(named: "new_tweet"), for: .normal)

        // ActionHandler
        btn.addTarget(self, action: #selector(actionBtnTapped), for: .touchUpInside)

        return btn
    }()
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureUI()
    }
    /**©-----------------------©*/
    
    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func actionBtnTapped() {
        printf(123)
    }
    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        typealias v = UIView

        view.addSubview(actionBtn)
        // actionBtn constraints
        // safeAreaLayoutGuide:--? Makes it look correct on different devices
        actionBtn.anchorWith(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                paddingBottom: 64, paddingRight: 16, width: 56, height: 56)

        // Adding rounded corners to our button
        actionBtn.layer.cornerRadius = 56/2
    }

    /* Programmatically creates all the
    view controllers for the application */
    func configureViewControllers() {
        // ViewControllers
        let feed = FeedViewController()
        let explore = ExploreViewController()
        let notifications = NotificationViewController()
        let conversations = ConvoViewController()

        /* Placing our controllers in navigation controllers &
           giving the tabs below there corresponding images.  */
        let feedNav = templateNavController(img: UIImage(named: "home_unselected"), rootViewController: feed)
        let exploreNav = templateNavController(img: UIImage(named: "search_unselected"), rootViewController: explore)
        let notificationsNav = templateNavController(img: UIImage(named: "like_unselected"), rootViewController: notifications)
        let conversationsNav = templateNavController(img: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        // Setting the view controllers
        /* An array of the root view controllers
           displayed by the tab bar interface. */
        viewControllers = [ feedNav, exploreNav, notificationsNav, conversationsNav ]
    }

    func templateNavController(img: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = img
        nav.navigationBar.tintColor = .white

        return nav
    }
    /**©-------------------------------------------©*/
}// END OF CLASS






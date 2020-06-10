import UIKit
import Firebase

class MainTabController: UITabBarController {

    // MARK: _©Computed-property
    var user: User? {
        didSet {
            /* open var viewControllers: [UIViewController]?
              -------------------------------------------------------
              Remember all our view controllers are embedded inside
              a navigation controller like so:
              index[0]: let feed = FeedViewController()
              index[1]: let explore = ExploreViewController()
              index[2]: let notifications = NotificationViewController()
              index[3]: let conversations = ConvoViewController()
              -------------------------------------------------------
              that is we cast the array of view controller to a
              UINavigationController then add the first feed which is feed! */
            guard let nav: UINavigationController = viewControllers?[0]
                    as? UINavigationController else { return }

            guard let feed: FeedViewController = nav.viewControllers.first
                    as? FeedViewController else { return }

            // Now we should see our user set in the feed controller from
            // the main tab And have access to all of our public properties
            feed.user = user
            printf("DEBUG: Did set user in main tab...") 
        }
    }

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

//        logUserOut()
        // So that the screen does not look black
        // briefly when rendering a view controller
        view.backgroundColor = .twitterBlue
        authUserAndConfigUI()
    }
    /**©-----------------------©*/

    // MARK: _#API
    /**©-------------------------------------------©*/
    
    func fetchUserFromDB() {
        UserService.shared.fetchUser { (user: User) in
            // The code wont execute until the user is actually fetched
            self.user = user// Passing our user computed property
            printf("DEBUG: Main tab user: \(user.username)")
        }
    }
    
    func authUserAndConfigUI() {
        if AUTH.currentUser == nil {
            // Has to be run on the main thread
            DispatchQueue.main.async {
                // If the user is not logged in, the view will segue to the LoginViewController
                let navVC = UINavigationController(rootViewController: LoginViewController())
                /* This will make sure that the LoginViewController screen is full to the
                   top and the user cant just slide the LoginViewController to get to the
                   screen stacked under it. */
                navVC.modalPresentationStyle = .fullScreen

                self.present(navVC, animated: true, completion: nil)
                printf("DEBUG: User is not logged in...")
            }
        } else {
            configureViewControllers()
            configureUI()
            /* We want to fetch the current user if not nil. That is why we
               call the function here and not in the viewDidLoad() method */
            fetchUserFromDB()
            printf("DEBUG: User is logged in...")

        }
    }

    func logUserOut() {
        do  {
            try AUTH.signOut()
            printf("DEBUG: Logged user out...")
        } catch {
            printf("Failed to sign out..--> \(error.localizedDescription)")
        }
    }
    /**©-------------------------------------------©*/
    
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
        let feedNav: UINavigationController = templateNavController(img: UIImage(named: "home_unselected"), rootViewController: feed)
        let exploreNav: UINavigationController = templateNavController(img: UIImage(named: "search_unselected"), rootViewController: explore)
        let notificationsNav: UINavigationController = templateNavController(img: UIImage(named: "like_unselected"), rootViewController: notifications)
        let conversationsNav: UINavigationController = templateNavController(img: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
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






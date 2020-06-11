import UIKit

class UploadTweetViewController: UIViewController {

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

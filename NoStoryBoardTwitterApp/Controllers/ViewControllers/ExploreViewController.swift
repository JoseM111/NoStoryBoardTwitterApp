import UIKit

class ExploreViewController: UIViewController {

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

    // MARK: _#Selectors
    /**©-------------------------------------------©*/

    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        view.backgroundColor = .white
        /* navigationItem:--? The navigation item used to represent
           the view controller in a parent's navigation bar. */
        navigationItem.title = "Explore"
    }
    /**©-------------------------------------------©*/
}

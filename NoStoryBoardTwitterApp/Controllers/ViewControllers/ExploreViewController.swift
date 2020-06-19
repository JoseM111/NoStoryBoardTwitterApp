import UIKit

class ExploreViewController: UITableViewController {

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

        tableView.register(UserCell.self, forCellReuseIdentifier: USER_IDENTIFIER)
        tableView.rowHeight = 60
        // Removes the separators in the table view
        tableView.separatorStyle = .none
    }
    /**©-------------------------------------------©*/

}// END OF CLASS

extension ExploreViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: USER_IDENTIFIER, for: indexPath)
                as? UserCell else { return UserCell() }

        return cell
    }
}

import UIKit

class ExploreViewController: UITableViewController {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // MARK: _$Source-of-truth
    internal var listOfUsers = [User]() {
        didSet { tableView.reloadData() }
    }

    // MARK: _$Source-of-truth
    internal var filteredUsers = [User]() {
        didSet { tableView.reloadData() }
    }

    internal var inSearchMode: Bool {
        searchController.isActive
                && !(searchController.searchBar.text?.isEmpty ?? false)
    }

    // Creating a search controller to filter through the users
    internal let searchController = UISearchController(searchResultsController: nil)
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchUsers()
        configureSearchController()
    }

    // Every time our view will appear it will hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Will make the top bar with the time and battery life to white
        navigationController?.navigationBar.barStyle = .default
        // Reverts nav bar to the state prior to going to the profile controller
        navigationController?.navigationBar.isHidden = false
    }
    /**©-----------------------©*/

    // MARK: _#API
    /**©-------------------------------------------©*/
    func fetchUsers() {
        UserService.shared.fetchListOfUsers { (users: [User]) in
            self.listOfUsers = users

//            for user in users {
//                printf("User: \(user.username)")
//            }
        }
    }
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
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false

        // Place holder text for the search bar
        searchController.searchBar.placeholder = "Search for user...".lowercased()
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    /**©-------------------------------------------©*/

}// END OF CLASS

extension ExploreViewController: UISearchResultsUpdating {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filterSearch = inSearchMode ? filteredUsers.count : listOfUsers.count
        return filterSearch
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell: UserCell = tableView.dequeueReusableCell(withIdentifier: USER_IDENTIFIER, for: indexPath)
                as? UserCell else { return UserCell() }

        let users: User = inSearchMode ? filteredUsers[indexPath.row] : listOfUsers[indexPath.row]

        // Must be set to render the cell with the
        // proper user data in the explore cell
        cell.user = users
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Grabs the correct user, based on weather or not we are in search mode
        let users: User = inSearchMode ? filteredUsers[indexPath.row] : listOfUsers[indexPath.row]
        let profileViewController = ProfileViewController(user: users)
        navigationController?.pushViewController(profileViewController, animated: true)
    }

    // MARK: #©Func from-->UISearchResultsUpdating
    public func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        /* Returns a new collection of the same type containing, in order, the
           elements of the original collection that satisfy the given predicate. */
        filteredUsers = listOfUsers.filter { $0.username.contains(searchText) }

    }

}

import UIKit

class ProfileViewController: UICollectionViewController {

    // MARK: _©Properties
    let user: User

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    init(user: User) {
        self.user = user

        /* UICollectionViewFlowLayout():--?
           A flow layout works with the collection view’s delegate object
           to determine the size of items, headers, and footers in each
           section and grid. That delegate object must conform to the
           UICollectionViewDelegateFlowLayout protocol. Use of the delegate
           allows you to adjust layout information dynamically. */
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()

        printf("DEBUG: USER: \(user.username)")
    }

    // Every time our view will appear it will hide the navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Will make the top bar with the time and battery life to white
        navigationController?.navigationBar.barStyle = .black
        // Hiding the nav bar to render our own custom bar
        navigationController?.navigationBar.isHidden = true
    }

    /**©-----------------------©*/

    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func handleDismissal() {

    }
    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureCollectionView() {

        collectionView.backgroundColor = .white
        // Will place the header all the way to the top of the screen
        collectionView.contentInsetAdjustmentBehavior = .never

        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: REUSE_IDENTIFIER)
        // Registering our ProfileHeader
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HEADER_IDENTIFIER)
    }

    /**©-------------------------------------------©*/
}// END OF CLASS

// MARK: _©extension|ProfileViewController|:[  ]
/**©-----------------------©*/
extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    // MARK: _©overriding funcs
    /**©-------------------------------------------©*/
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result: Int = 3
        return result
    }

    // Sets up our tweet cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath)
                as? TweetCell else { return TweetCell() }

        return cell
    }

    // Registers the header of the profile
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header: ProfileHeader = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_IDENTIFIER, for: indexPath)
                as? ProfileHeader else { return ProfileHeader() }

        header.user = user
        return header
    }

    // Sets up our header in our profile
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {

        /* Will create the header space to render our profile information.
           Size of header. */
        CGSize(width: view.frame.width, height: 350)
    }

    // Formats our tweet cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Will return the number in sections(numberOfItemsInSection)
        // in the frames width and the height specified formatted nicely
        CGSize(width: view.frame.width, height: 120)
    }

    /**©-------------------------------------------©*/
}
/**©-----------------------©*/

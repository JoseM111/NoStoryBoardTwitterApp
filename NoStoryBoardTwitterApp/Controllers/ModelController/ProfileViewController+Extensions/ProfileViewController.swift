import UIKit

class ProfileViewController: UICollectionViewController {

    // MARK: _©Properties
    let user: User

    // MARK: #©Data-source
    internal var tweets: [Tweet] = [] {
        /* As soon as this property is set we want it to
           reload its data, to render whats in the database.
           We Have to run this for `numberOfItemsInSection`
           to work in the `extension` of `FeedViewController`
           Will render sections depending on the number of
           tweets in the firebase database. */
        didSet { collectionView.reloadData() }
    }

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
        fetchTweets()
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

    // MARK: _#API
    /**©-------------------------------------------©*/
    func fetchTweets() {
        TweetService.shared.fetchTweetsFor(user: user) { (tweets: [Tweet]) in
            self.tweets = tweets

            printf("""
                   DEBUG: SUCCESS!..
                   Number of tweets: \(tweets.count)
                   """)
        }
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


import UIKit
import SDWebImage

class FeedViewController: UICollectionViewController {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
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

    // MARK: _©Computed-property
    var user: User? {
        didSet {
            // Must be set and called before the configureUI() method
            // because there isn't a user, until a user is set!
            configureLeftBarBtn()
            printf("DEBUG: Did set user in feed controller...")
        }
    }

    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        fetchTweet()
    }
    /**©-----------------------©*/

    // MARK: _#API
    func fetchTweet() {

        TweetService.shared.fetchTweets { (tweets: [Tweet]) in
            self.tweets = tweets

            printf("DEBUG:\nTweets #\(tweets.count)")
        }
    }

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {
        view.backgroundColor = .white

        // Collection view
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: REUSE_IDENTIFIER)
        collectionView.backgroundColor = .white

        // Setup our twitter logo at the top of the nav bar
        let twitterImgView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        // How the image is going to get fit inside of the image view
        twitterImgView.contentMode = .scaleAspectFit
        // Setting the dimensions so our twitter images
        // does not move when adding the user image
        twitterImgView.setDimensions(width: 44, height: 44)
        /* .titleView:--? A custom view displayed in the center of
            the navigation bar when the receiver is the top item. */
        navigationItem.titleView = twitterImgView

    }

    func configureLeftBarBtn() {
        // This guarantees our user exist. If the
        // use does not exist, the function stops here.
        guard let user: User = user else { return }

        let profileImgView = UIImageView()
        profileImgView.setDimensions(width: 42, height: 42)
        profileImgView.layer.cornerRadius = 42 / 2

        /* When the value of this property is true, Core Animation creates
         an implicit clipping mask that matches the bounds of the layer and
         includes any corner radius effects. Makes the user image circular. */
        profileImgView.layer.masksToBounds = true
        // Setting our sd image
        profileImgView.sd_setImage(with: user.profileImgURL, completed: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImgView)
    }
    /**©-------------------------------------------©*/
}

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tweets.count // Will render five cells
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath)
        as? TweetCell else { return TweetCell() }

        // Populates the cell with the correct tweet in that index path
        cell.tweet = tweets[indexPath.row]

        return cell
    }

    // Asks the delegate for the size of the specified item’s cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Will return the number in sections(numberOfItemsInSection)
        // in the frames width and the height specified
        CGSize(width: view.frame.width, height: 120)
    }
}

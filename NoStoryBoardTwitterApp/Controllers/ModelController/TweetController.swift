import UIKit

class TweetController: UICollectionViewController {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    internal let tweet: Tweet
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    init(tweet: Tweet) {
        self.tweet = tweet
        // must call super init of -->
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        printf("DEBUG: Tweet caption: \(tweet.caption)")
    }
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white

        // Registering our TweetCell
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: TWEET_IDENTIFIER)
        // Registering our TweetHeader
        collectionView.register(TweetHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TWEET_HEADER_IDENTIFIER)
    }

    /**©-----------------------©*/

    // MARK: _#Selectors
    /**©-------------------------------------------©*/

    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/


    /**©-------------------------------------------©*/
}

extension TweetController: UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result = 3
        return result
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: TWEET_IDENTIFIER, for: indexPath)
        as? TweetCell else { return TweetCell() }


        return cell
    }

    // Registers the header of the profile
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        //\__________
        guard let header: TweetHeader = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TWEET_HEADER_IDENTIFIER, for: indexPath)
                as? TweetHeader else { return TweetHeader() }

        return header
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    // Defines the size of our header in our tweet cell
    /*©-------------------------------------------©*/
    // Sets up our header in our profile
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {

        /* Will create the header space to render our profile information. Size of header. */
        CGSize(width: view.frame.width, height: 350)
    }

    // Formats our tweet cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Will return the number in sections(numberOfItemsInSection)
        // in the frames width and the height specified formatted nicely
        /* Will return the number in sections(numberOfItemsInSection)
        in the frames width and the height specified formatted nicely */
        CGSize(width: view.frame.width, height: 120)
    }
}

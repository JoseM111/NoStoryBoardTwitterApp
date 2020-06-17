import UIKit

extension FeedViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tweets.count // Will render cells depending on amount of tweets
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath)
                as? TweetCell else { return TweetCell() }

        // You have to set your delegate or it will be equal to nil
        /* Self references our FeedViewController which conforms to TweetCellDelegate */
        cell.tweetCellDelegate = self
        // Populates the cell with the correct tweet in that index path
        cell.tweet = tweets[indexPath.row]

        return cell
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }

    // Asks the delegate for the size of the specified item’s cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Will return the number in sections(numberOfItemsInSection)
        // in the frames width and the height specified
        CGSize(width: view.frame.width, height: 120)
    }
}

extension FeedViewController: TweetCellDelegate {
    // MARK: _©Stubs--> For TweetCellDelegate
    /**©-------------------------------------------©*/
    func handleProfileImgTapped() {
        /* When the image os tapped, it will forward you to the ProfileViewController  */
        let profileController = ProfileViewController(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(profileController, animated: true)

        printf("""
               -->Profile imaged tapped...
               -->Forwarding to profile controller...
               """)
    }
    /**©-------------------------------------------©*/

}


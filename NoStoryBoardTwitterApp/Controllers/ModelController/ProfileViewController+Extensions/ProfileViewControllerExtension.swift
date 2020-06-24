import UIKit

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

    /**©-------------------------------------------©*/
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tweets.count
    }

    // Sets up our tweet cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell: TweetCell = collectionView.dequeueReusableCell(withReuseIdentifier: TWEET_IDENTIFIER, for: indexPath)
                as? TweetCell else { return TweetCell() }

        cell.tweet = tweets[indexPath.row]
        return cell
    }

    // Registers the header of the profile
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {

        guard let header: ProfileHeader = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PROFILE_HEADER_IDENTIFIER, for: indexPath)
                as? ProfileHeader else { return ProfileHeader() }

        header.user = user
        header.profileHeaderDelegate = self
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

extension ProfileViewController: ProfileHeaderDelegate {

    func handleEditProfileFollow(_ header: ProfileHeader) {
        // __________
        if user.isCurrentUser {
            return printf("DEBUG: Showing edit profile controller...")
        }

        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user.uid) { _, _ in
                self.user.isFollowed = false
                // Reloads and runs all the functions again
                self.collectionView.reloadData()
            }
        } else {
            UserService.shared.followUser(uid: user.uid) { _, _ in
                self.user.isFollowed = true
                // Reloads and runs all the functions again
                self.collectionView.reloadData()
            }
        }
    }

    func handleDismissal() {
        /* Will pop the view back to the controller it came
           from, once the back button is tapped. */
        navigationController?.popViewController(animated: true)
        printf("DEBUG: Dismiss profile from ProfileController...")
    }
}
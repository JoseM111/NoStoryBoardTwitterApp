import UIKit

extension ProfileFilterView: UICollectionViewDataSource, UICollectionViewDelegate {

    // Animates the label cell transition when selecting the index of that cell.
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterViewDelegate?.animateFilterView(self, didSelect: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let result: Int = 3
        return result
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell: ProfileFilterCell = collectionView.dequeueReusableCell(withReuseIdentifier: PROFILE_FILTER_IDENTIFIER, for: indexPath)
                as? ProfileFilterCell else { return ProfileFilterCell() }

        let option = ProfileFilterOptions(rawValue: indexPath.row)

        /* ?option was set in the ProfileFilterCell, as a computed property. With a didSet {}
        // Now the index path should render these labels on the profile header bottom as:
        //                 -->>| Tweets | Tweets & Replies | Likes |<<--                  */
        cell.option = option
        return cell
    }
}

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {

        // width: frame.width / 3 --? makes each one 1/3 of the views width
        CGSize(width: frame.width / 3, height: frame.height)
    }

    /* implementation of this method can return a fixed value or return different spacing values for each section */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let result: CGFloat = 0
        return result//<---0 spacing between views
    }
}

import UIKit

extension ProfileFilterView: UICollectionViewDataSource, UICollectionViewDelegate {

    // Animates the label cell transition when selecting the index of that cell.
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterViewDelegate?.animateFilterView(self, didSelect: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        /* Using the CaseIterable from our ProfileFilterOptions enum
           <-- No need t update the cell count manually.
           You can now update the enum cases and they will always adjust.
           Since they conform to: enum ProfileFilterOptions: Int, CaseIterable,
           the Int will be the indexes of the cells/views and CaseIterable
           will be the cases being iterated through as the labels are tapped */
        ProfileFilterOptions.allCases.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell: ProfileFilterCell = collectionView.dequeueReusableCell(withReuseIdentifier: PROFILE_FILTER_IDENTIFIER, for: indexPath)
                as? ProfileFilterCell else { return ProfileFilterCell() }

        let option: ProfileFilterOptions? = ProfileFilterOptions(rawValue: indexPath.row)

        /* ?option was set in the ProfileFilterCell, as a computed property. With a didSet {}
        // Now the index path should render these labels on the profile header bottom as:
        //__________________-->>| Tweets | Tweets & Replies | Likes |<<--__________________*/
        cell.option = option
        return cell
    }
}

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        /* Using the CaseIterable from our ProfileFilterOptions enum
           <-- No need t update the cell count manually.
           You can now update the enum cases and they will always adjust.
           Since they conform to: enum ProfileFilterOptions: Int, CaseIterable,
           the Int will be the indexes of the cells/views and CaseIterable
           will be the cases being iterated through as the labels are tapped */
        let count = CGFloat(ProfileFilterOptions.allCases.count)

        // width: frame.width / 3 --? makes each one 1/3 of the views width
        return CGSize(width: frame.width / count, height: frame.height)
    }

    /* implementation of this method can return a fixed value or return different spacing values for each section */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let result: CGFloat = 0
        //0 spacing between views
        return result
    }
}

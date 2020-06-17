import UIKit

protocol ProfileFilterViewDelegate: class {
    func animateFilterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {

    // MARK: _#ProfileFilterViewDelegate delegate
    weak var filterViewDelegate: ProfileFilterViewDelegate?

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // A collection view for the profile controller button/bottom tabs
    internal lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white

        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Registering the ProfileFilterCell
        collectionView.register(ProfileFilterCell.self, forCellWithReuseIdentifier: PROFILE_FILTER_IDENTIFIER)

        // So tweets is selected by default
        let selectIndexPath = IndexPath(row: 0, section: 0)//<--isSelected = true on index 0 by default
        collectionView.selectItem(at: selectIndexPath, animated: true, scrollPosition: .left)

        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}// END OF CLASS

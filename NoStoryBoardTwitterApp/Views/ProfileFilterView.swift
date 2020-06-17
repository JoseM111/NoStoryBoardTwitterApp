import UIKit

class ProfileFilterView: UIView {

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
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}// END OF CLASS

extension ProfileFilterView: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell: ProfileFilterCell = collectionView.dequeueReusableCell(withReuseIdentifier: PROFILE_FILTER_IDENTIFIER, for: indexPath)
                as? ProfileFilterCell else { return ProfileFilterCell() }

        return cell
    }
}

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {

        // width: frame.width / 3 --? makes each one 1/3 of the views width
        CGSize(width: frame.width / 3, height: frame.height)
    }

    /* implementation of this method can return a fixed value or return different spacing values for each section */
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        0//<---0 spacing between views
    }
}

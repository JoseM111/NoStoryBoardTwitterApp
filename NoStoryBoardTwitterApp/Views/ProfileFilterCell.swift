import UIKit

class ProfileFilterCell: UICollectionViewCell {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    //<--titleLbl
    internal let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Test filter"
        return lbl
    }()

    // Inherited
    override var isSelected: Bool {
        didSet {
            let boldFont: UIFont = UIFont.boldSystemFont(ofSize: 16)
            let regFont: UIFont = UIFont.systemFont(ofSize: 14)

            titleLbl.font = isSelected ? boldFont : regFont
            titleLbl.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubview(titleLbl)
        titleLbl.centerX(inView: self)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /**©-----------------------©*/

    // MARK: _#Selectors
    /**©-------------------------------------------©*/

    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/


    /**©-------------------------------------------©*/
}

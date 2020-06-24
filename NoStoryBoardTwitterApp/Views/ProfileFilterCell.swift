import UIKit

class ProfileFilterCell: UICollectionViewCell {

    //<--cell description property--? tweets/replies/likes
    var option: ProfileFilterOptions? {
        // Will set the option to the right index, when the label is selected
        didSet { titleLbl.text = option?.description }
    }

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

    /* When the title label is selected for a cell,
       the color of that label will be set to true
       which will make the label in that cell change
       colors to blue and keep the other to labels
       in the other cells light gray and false. */
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
}

import UIKit

class UserCell: UITableViewCell {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // -->profileImgView must be a lazy var
    internal lazy var profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        // How big the image view will be
        iv.setDimensions(width: 42, height: 42)

        // width/Height = 48 which will give us a full circle if divided
        // by 2. This only works when the width & the height are the same.
        iv.layer.cornerRadius = 42 / 2
        iv.backgroundColor = .twitterBlue

        return iv
    }()

    // -->usernameLbl: UILabel
    internal let usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.text = "Username"

        return lbl
    }()

    // -->fullnameLbl: UILabel
    internal let fullnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Fullname"

        return lbl
    }()

    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        // Adding our image and anchoring it to the left of the table view cell.
        addSubview(profileImgView)
        profileImgView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)

        // MARK: _©Vertical Stack
        /**©-----------------------©*/
        let vCellStack = UIStackView(arrangedSubviews: [ usernameLbl, fullnameLbl ])
        vCellStack.axis = .vertical
        vCellStack.spacing = 2

        addSubview(vCellStack)
        vCellStack.centerY(inView: profileImgView, leftAnchor: profileImgView.rightAnchor,
                           paddingLeft: 12)
        /**©-----------------------©*/

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
}// END OF CLASS

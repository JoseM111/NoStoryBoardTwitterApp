import UIKit

class ProfileHeader: UICollectionReusableView {

    internal let filterBarAnimationTransition = ProfileFilterView()

    var user: User? {
        didSet { configureUserToSet() }
    }

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // -->containerView: UIView
    internal lazy var containerView: UIView = {
        let cView = UIView()
        cView.backgroundColor = .twitterBlue

        cView.addSubview(backBtn)
        backBtn.anchorWith(top: cView.topAnchor, left: cView.leftAnchor, paddingTop: 42, paddingLeft: 16)
        backBtn.setDimensions(width: 30, height: 30)

        return cView
    }()

    // -->backBtn: UIButton
    internal lazy var backBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)

        return btn
    }()

    // -->profileImgView: UIImageView
    internal lazy var profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4

        return iv
    }()

    // -->editProfileFollowBtn: UIButton
    internal lazy var editProfileFollowBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.borderColor = UIColor.twitterBlue.cgColor
        btn.layer.borderWidth = 1.25

        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return btn
    }()

    // -->fullnameLbl: UILabel
    internal let fullnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "Alias111"
        lbl.textColor = .lightGray
        return lbl
    }()

    // -->usernameLbl: UILabel
    internal let usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "@alias_one11"
        lbl.textColor = .lightGray
        return lbl
    }()

    // -->bioLbl: UILabel
    internal let bioLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.numberOfLines = 3
        lbl.text = "This is the users bio, that will span more then one line, but less then three lines."

        return lbl
    }()

    // -->underlineView: UIView
    internal let underlineView: UIView = {
        let uView = UIView()
        uView.backgroundColor = .twitterBlue
        return uView
    }()

    // -->followingLabel: UILabel
    internal let followingLbl: UILabel = {
        let lbl = UILabel()
        // Dummy text

        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(followTap)
        return lbl
    }()

    // -->followingLabel: UILabel
    internal let followersLbl:UILabel = {
        let lbl = UILabel()
        // Dummy text

        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        lbl.isUserInteractionEnabled = true
        lbl.addGestureRecognizer(followTap)

        return lbl
    }()
    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override init(frame: CGRect) {
        super.init(frame: frame)

        filterBarAnimationTransition.filterViewDelegate = self

        addSubview(containerView)
        containerView.anchorWith(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)

        // Profile image view
        addSubview(profileImgView)
        // paddingTop: -24:--? makes the image go up into the container view
        profileImgView.anchorWith(top: containerView.bottomAnchor, left: leftAnchor,
                                  paddingTop: -24, paddingLeft: 8)

        // Profile image size
        profileImgView.setDimensions(width: 80, height: 80)
        // Adding a rounded radius on the image
        profileImgView.layer.cornerRadius = 80 / 2

        // Adding follow button
        addSubview(editProfileFollowBtn)
        editProfileFollowBtn.anchorWith(top: containerView.bottomAnchor, right: rightAnchor,
                                        paddingTop: 12, paddingRight: 12)

        editProfileFollowBtn.setDimensions(width: 100, height: 36)
        // Will make the end corner radius of the follow button rounded
        editProfileFollowBtn.layer.cornerRadius = 36 / 2

        // MARK: _©Vertical-stackView
        /**©-------------------------------------------©*/
        let vUserDetailStack = UIStackView(arrangedSubviews: [ fullnameLbl, usernameLbl, bioLbl ])
        vUserDetailStack.axis = .vertical
        vUserDetailStack.distribution = .fillProportionally
        // 4 pixels of space between elements
        vUserDetailStack.spacing = 4

        // MARK: _#Adding subview
        addSubview(vUserDetailStack)
        vUserDetailStack.anchorWith(top: profileImgView.bottomAnchor, left: leftAnchor, right: rightAnchor,
                                    paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        /**©-------------------------------------------©*/

        // MARK: _#Following & Followers label in a hStack
        /**©-------------------------------------------©*/
        let hFollowStack = UIStackView(arrangedSubviews: [ followingLbl, followersLbl ])
        hFollowStack.axis = .horizontal
        hFollowStack.spacing = 8
        hFollowStack.distribution = .fillEqually

        addSubview(hFollowStack)
        hFollowStack.anchorWith(top: vUserDetailStack.bottomAnchor, left: leftAnchor,
                                paddingTop: 8, paddingLeft: 12)
        /**©-------------------------------------------©*/

        // Adding our filterBar/ProfileFilterView to the bottom of our profile header
        // Adjust height if bar is to close or far when animated under the label cell
        addSubview(filterBarAnimationTransition)
        filterBarAnimationTransition.anchorWith(left: leftAnchor, bottom: bottomAnchor,
                                                right: rightAnchor, height: 35)

        // Adding underlining view
        addSubview(underlineView)
        underlineView.anchorWith(left: leftAnchor, bottom: bottomAnchor,
                                 width: frame.width / 3, height: 2)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func handleFollowingTapped() {

    }

    @objc func handleFollowersTapped() {

    }

    @objc func handleDismissal() {

    }

    @objc func handleEditProfileFollow() {

    }
    /**©-------------------------------------------©*/
    
    // MARK: _#Helper
    /**©-----------------------©*/
    func configureUserToSet() {
        guard let user = user else { return }
        // Using our user to construct our view model
        let profileHeaderViewModel = ProfileHeaderViewModel(user: user)

        // Configuring the correct image for the profile
        profileImgView.sd_setImage(with: user.profileImgURL)

        /*  if user.isCurrentUser { return "Edit Profile" }
                else { return "Follow" }                   */
        editProfileFollowBtn.setTitle(profileHeaderViewModel.actionBtnTitle, for: .normal)

        followersLbl.attributedText = profileHeaderViewModel.followersStr
        followingLbl.attributedText = profileHeaderViewModel.followingStr
    }
    /**©-----------------------©*/
}// END OF CLASS

extension ProfileHeader: ProfileFilterViewDelegate {

    func animateFilterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell: ProfileFilterCell = view.collectionView.cellForItem(at: indexPath)
                as? ProfileFilterCell else { return }

        let xPos: CGFloat = cell.frame.origin.x

        UIView.animate(withDuration: 0.3) { () -> Void in
            self.underlineView.frame.origin.x = xPos
        }
    }
}

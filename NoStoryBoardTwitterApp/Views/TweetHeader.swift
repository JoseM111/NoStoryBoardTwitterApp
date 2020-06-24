import UIKit

class TweetHeader: UICollectionReusableView {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // -->profileImgView must be a lazy var
    internal lazy var profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        // How big the image view will be
        iv.setDimensions(width: 52, height: 52)

        // width/Height = 48 which will give us a full circle if divided
        // by 2. This only works when the width & the height are the same.
        iv.layer.cornerRadius = 52 / 2
        iv.backgroundColor = .twitterBlue

        /* Adding a tap gesture recognizer:
           Handles a tapping event on a none button. */
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleProfileImgTapped))
        // Adding our gesture to the profileImgView
        iv.addGestureRecognizer(tapGestureRecognizer)
        // Not enabled by default
        iv.isUserInteractionEnabled = true

        return iv
    }()

    // -->fullnameLbl: UILabel
    internal let fullnameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "Alias The-Great"
        return lbl
    }()

    // -->usernameLbl: UILabel
    internal let usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .lightGray
        lbl.text = "@elhombre"
        return lbl
    }()

    // -->captionLbl: UILabel
    internal let captionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.numberOfLines = 0//<-- It means it has a unlimited amount of lines
        lbl.text = "Some text talking blah, cause i can so what what... You hear me homie???"
        return lbl
    }()

    // -->dateLbl: UILabel
    let dateLbl: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.text = "3:16 PM - 7/11/2020"
        return lbl
    }()

    // -->optionsBtn: UIButton
    let optionsBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .lightGray
        btn.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        btn.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)

        return btn
    }()

    // -->retweetsBtn: UIButton
    internal lazy var retweetsLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "2 Retweets"
        return lbl
    }()

    // -->likesBtn: UIButton
    internal lazy var likesLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.text = "0 Likes"
        return lbl
    }()

    // -->statsView: UIView(view with retweets and likes)
    internal lazy var statsView: UIView = {
        let view = UIView()

        view.backgroundColor = .red
        // Creating the top divider view that divided the stat view and the header
        let divTop = UIView()
        divTop.backgroundColor = .systemGroupedBackground
        view.addSubview(divTop)
        divTop.anchorWith(top: view.topAnchor, left: view.leftAnchor,
                          right: view.rightAnchor, paddingLeft: 8, height: 1.0)

        // Adding our labels(retweets/likes) to our statsView
        let hStack = UIStackView(arrangedSubviews: [ retweetsLbl, likesLbl ])
        hStack.axis = .horizontal
        hStack.spacing = 12

        view.addSubview(hStack)
        hStack.centerY(inView: view)
        hStack.anchorWith(left: view.leftAnchor, paddingLeft: 16)

        // Creating the bottom divider view that divided the stat view and the header
        let bottomTop = UIView()
        bottomTop.backgroundColor = .systemGroupedBackground
        view.addSubview(bottomTop)
        bottomTop.anchorWith(top: view.topAnchor, left: view.leftAnchor,
                          right: view.rightAnchor, paddingLeft: 8, height: 1.0)

        return view
    }()

    /**©------------------------------------------------------------------------------©*/

    // MARK: _©Lifecycle-methods
    /**©-----------------------©*/
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Placing our name label & username label in a vertical stack view
        let vLblStack = UIStackView(arrangedSubviews: [ fullnameLbl, usernameLbl ])
        vLblStack.axis = .vertical
        vLblStack.spacing = -6

        // Combining the vertical stack with horizontal stack that also has our profileImgView
        // You do not need to declare the axis, since it will default to horizontal
        let hStack = UIStackView(arrangedSubviews: [ profileImgView, vLblStack ])
        hStack.spacing = 12

        addSubview(hStack)
        hStack.anchorWith(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)

        // Setting up our caption label
        addSubview(captionLbl)
        captionLbl.anchorWith(top: hStack.bottomAnchor, left: leftAnchor,
                              right: rightAnchor, paddingTop: 15,
                              paddingLeft: 16, paddingRight: 16)

        // Setting up our date label
        addSubview(dateLbl)
        dateLbl.anchorWith(top: captionLbl.bottomAnchor, left: leftAnchor,
                           paddingTop: 20, paddingLeft: 16)

        // Setting up our optionsBtn
        addSubview(optionsBtn)
        optionsBtn.centerY(inView: hStack)
        optionsBtn.anchorWith(right: rightAnchor, paddingRight: 8)

        // Setting up our statsView
        addSubview(statsView)
        statsView.anchorWith(top: dateLbl.bottomAnchor, left: leftAnchor,
                             right: rightAnchor, paddingTop: 20, height: 40)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /**©-----------------------©*/

    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func handleProfileImgTapped() {
        printf("DEBUG: Going to user profile...")
    }
    
    @objc func showActionSheet() {
        printf("DEBUG: Shows action sheet...")
    }
    
    @objc func handleRetweetsTapped() {

    }
    
    @objc func handleLikesTapped() {
        
    }
    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/


    /**©-------------------------------------------©*/
}

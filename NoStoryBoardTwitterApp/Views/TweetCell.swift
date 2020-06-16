import UIKit

class TweetCell: UICollectionViewCell {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // -->profileImgView
    var tweet: Tweet? {
        didSet { configureTweet() }
    }

    // -->profileImgView
    internal let profileImgView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        // How big the image view will be
        iv.setDimensions(width: 52, height: 52)

        // width/Height = 48 which will give us a full circle if divided
        // by 2. This only works when the width & the height are the same.
        iv.layer.cornerRadius = 52 / 2
        iv.backgroundColor = .twitterBlue

        return iv
    }()

    // -->Caption
    internal let captionLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.text = "Some caption text"
        // Gives our label an infinite number of lines
        lbl.numberOfLines = 0

        return lbl
    }()

    // -->Custom-Label
    internal let infoLbl = UILabel()

    // MARK: _©Buttons at the bottom of each cell
    /**©-------------------------------------------©*/
    internal lazy var commentBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "comment"), for: .normal)// SF.Symbol images
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleCommentsTapped), for: .touchUpInside)

        return btn
    }()

    internal lazy var retweetBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "retweet"), for: .normal)// SF.Symbol images
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)

        return btn
    }()

    internal lazy var likeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "like"), for: .normal)// SF.Symbol images
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleLikesTapped), for: .touchUpInside)

        return btn
    }()

    internal lazy var shareBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "share"), for: .normal)// SF.Symbol images
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        btn.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        
        return btn
    }()
    /**©-------------------------------------------©*/

    /**©------------------------------------------------------------------------------©*/

    // MARK: #©Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        addSubview(profileImgView)
        // Constraints
        profileImgView.anchorWith(top: topAnchor, left: leftAnchor,
                                  paddingTop: 8, paddingLeft: 8)

        // MARK: _©Adding infoLbl, captionLbl to a vertical stack
        /**©-------------------------------------------©*/
        let vStack = UIStackView(arrangedSubviews: [ infoLbl, captionLbl ])
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        vStack.spacing = 4

        addSubview(vStack)
        vStack.anchorWith(top: profileImgView.topAnchor, left: profileImgView.rightAnchor,
                          right: rightAnchor, paddingLeft: 12, paddingRight: 12)

        // -->Custom-Label
        infoLbl.font = UIFont.systemFont(ofSize: 14)
        infoLbl.text = "Just do it @Nike"
        /**©-------------------------------------------©*/
        // MARK: _©Action Stack
        let actionHStack = UIStackView(arrangedSubviews: [ commentBtn, retweetBtn,
                                                           likeBtn, shareBtn ])

        actionHStack.axis = .horizontal
        // Spacing between buttons
        actionHStack.spacing = 72

        addSubview(actionHStack)
        // Center it on the x axis
        actionHStack.centerX(inView: self)
        actionHStack.anchorWith(bottom: bottomAnchor, paddingBottom: 8)
        /**©-------------------------------------------©*/

        // View with...
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchorWith(left: leftAnchor, bottom: bottomAnchor,
                                 right: rightAnchor, height: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: _#Selectors
    /**©-------------------------------------------©*/
    @objc func handleShareTapped() {
        
    }
    
    @objc func handleLikesTapped() {
        
    }
    
    @objc func handleCommentsTapped() {

    }

    @objc func handleRetweetTapped() {
        
    }
    /**©-------------------------------------------©*/

    // MARK: _#Helpers
    /**©-------------------------------------------©*/
    func configureTweet() {
        guard let tweet: Tweet = tweet else { return }
        let tweetViewModel = TweetViewModel(tweet: tweet)
        // Will show what was tweeted
        captionLbl.text = tweet.caption

        profileImgView.sd_setImage(with: tweetViewModel.profileImgURL)
        infoLbl.attributedText = tweetViewModel.userInfoText

        printf("""
               DEBUG: 
               Tweet User Name: \(tweetViewModel.userInfoText)
               Caption tweeted by user: \(tweet.caption)
               """)
    }
    /**©-------------------------------------------©*/


}

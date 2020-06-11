import UIKit

class CaptionTxtView: UITextView {

    // MARK: _©Properties
    /**©------------------------------------------------------------------------------©*/
    // -->placeHolderLbl
    let placeHolderLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .darkGray
        lbl.text = "What's happening?.."
        return lbl
    }()

    /**©------------------------------------------------------------------------------©*/

    // MARK: _#Lifecycle
    /**©-------------------------------------------©*/
    /* CGRect: A structure that contains the location
       and dimensions of a rectangle.
       ----------------------------------------------------------
       NSTextContainer: Summary A region where text is laid out */
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        // No need to say view.foo because it is already a sub class of UIView
        backgroundColor = .white //<--[NOTE]Change the color to see the size of the view
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true

        addSubview(placeHolderLbl)
        placeHolderLbl.anchorWith(top: topAnchor, left: leftAnchor,
                                  paddingTop: 8, paddingLeft: 4)

        // To remove the placeholder text once the user starts typing
        NotificationCenter.default.addObserver(self, selector: #selector(handleClearPlaceholder),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    // Must initialize
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: _#Selector
    // To remove the placeholder text once the user starts typing
    @objc func handleClearPlaceholder() {
        placeHolderLbl.isHidden = !text.isEmpty
    }

    /**©-------------------------------------------©*/

    // MARK: _©Helper-methods
    /**©-------------------------------------------©*/
    func configureUI() {

    }

    /**©-------------------------------------------©*/
}// END OF CLASS

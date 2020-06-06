import UIKit

class Utilities {

    // MARK: _©inputContainerViewWith() -> UIView
    //Creating a image view in our container
    static func inputContainerViewWith(uiView: UIView, uiImgView: UIImageView, named: String,
                                       anchorPaddingLeft: CGFloat, anchorPaddingBottom: CGFloat,
                                       dimensionWidth: CGFloat, dimensionHeight: CGFloat, txtField: UITextField) -> UIView {

        uiView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        uiImgView.image = UIImage(named: named)
        // Adding the emailImgUIView to the container parent view
        uiView.addSubview(uiImgView)

        // Adding constraints
        uiImgView.anchorWith(left: uiView.leftAnchor, bottom: uiView.bottomAnchor,
                             paddingLeft: anchorPaddingLeft, paddingBottom: anchorPaddingBottom)
        // Sets the size of the image inside the uiview
        uiImgView.setDimensions(width: dimensionWidth, height: dimensionHeight)

        // Adding our text field
        uiView.addSubview(txtField)
        txtField.anchorWith(left: uiImgView.rightAnchor, bottom: uiView.bottomAnchor,
                            right: uiView.rightAnchor, paddingLeft: 8, paddingBottom: 8)

        // Adding a divider ____ Under our text fields
        let dividerView = UIView()
        dividerView.backgroundColor = .white

        uiView.addSubview(dividerView)
        dividerView.anchorWith(left: uiView.leftAnchor, bottom: uiView.bottomAnchor,
                               right: uiView.rightAnchor, paddingLeft: 8, height: 0.75)

        return uiView
    }

    // MARK: #©textFieldWith() -> UITextField
    static func textFieldWith(placeHolder: String, fontSize: CGFloat) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: fontSize)

        /* The styled string that is displayed when there
           is no other text in the text field--> Or the text you type... */
        tf.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        return tf
    }

    // MARK: #©attrButton() -> UIButton
    static func attrButton(_ str1: String, _ str2: String) -> UIButton {
        let btn = UIButton(type: .system)

        let attrTitle = NSMutableAttributedString(
                string: str1,
                attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                             NSAttributedString.Key.foregroundColor: UIColor.white])

        attrTitle.append(NSAttributedString(
                string: str2,
                attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                             NSAttributedString.Key.foregroundColor: UIColor.white]))

        /* Use this method to set the title of the button, including any relevant
           formatting information. If you set both a title and an attributed title
           for the button, the button prefers the use of the attributed title. */
        btn.setAttributedTitle(attrTitle, for: .normal)
        return btn
    }
}

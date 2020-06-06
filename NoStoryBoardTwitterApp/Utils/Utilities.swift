import UIKit

class Utilities {

    // MARK: _©Creating a image view in our container
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

        return uiView
    }
}

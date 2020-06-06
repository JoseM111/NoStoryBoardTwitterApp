import UIKit

extension UIView {
    func anchorWith(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        // Activates auto-layout on the element in use
        translatesAutoresizingMaskIntoConstraints = false

        if let top = top { topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true }
        if let left = left { leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true }
        if let right = right { rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true }
        if let width = width { widthAnchor.constraint(equalToConstant: width).isActive = true }
        if let height = height { heightAnchor.constraint(equalToConstant: height).isActive = true }
    }

    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }

    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        if let topAnchor = topAnchor { self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true }
    }

    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        if let leftAnchor = leftAnchor, let padding = paddingLeft { self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true }
    }

    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchorWith(top: view.topAnchor, left: view.leftAnchor,
                bottom: view.bottomAnchor, right: view.rightAnchor)
    }
}

// MARK: - UIColor
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let twitterBlue = UIColor.rgb(red: 29, green: 161, blue: 242)
}

// MARK: - UIViewController
extension UIViewController {

    func addAllSubViews(obj1: UIView , obj2: UIView = UIView(), obj3: UIView = UIView()) {
        // MARK: -#[subview-additions]
        view.addSubview(obj1)
        view.addSubview(obj2)
        view.addSubview(obj3)
    }

//    func createStackView(axis: NSLayoutConstraint.Axis, vStack: UIStackView, obj: UIView, spacing: CGFloat, paddingTop: CGFloat, paddingLeft : CGFloat, paddingRight: CGFloat) {
//        vStack.axis = axis
//        vStack.spacing = spacing
//
//        view.addSubview(vStack)
//        vStack.anchorWith(top: obj.bottomAnchor, left: view.leftAnchor,
//                right: view.rightAnchor, paddingTop: paddingTop,
//                paddingLeft: paddingLeft, paddingRight: paddingRight)
//    }
//
//    func imgConstraints(obj: UIView,  ht: CGFloat, wt: CGFloat, paddingTop: CGFloat) { // Centering it on the x-axis
//        obj.centerX(inView: view)
//        // Setting the dimensions
//        obj.setDimensions(width: ht, height: ht)
//
//        // Anchoring it to the top & giving it a padding of 32
//        obj.anchorWith(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: paddingTop)
//    }
}

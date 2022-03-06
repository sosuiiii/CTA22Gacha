import UIKit

extension UITextField {
    func configure() {
        returnKeyType = .done
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
}

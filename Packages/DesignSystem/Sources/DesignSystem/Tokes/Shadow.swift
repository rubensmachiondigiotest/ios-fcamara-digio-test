import UIKit

public extension CALayer {
    func applyShadow(x: CGFloat = 0.0,
                     y: CGFloat = 2.0,
                     blur: CGFloat = 8.0,
                     spread: CGFloat = 0.0,
                     alpha: CGFloat = 0.16,
                     color: UIColor = Colors.Neutral.primaryTextColor.uiColor) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowOpacity = Float(alpha)
        shadowOffset = CGSize(width: x,
                              height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dimensionX = -spread
            let rect = bounds.insetBy(dx: dimensionX, dy: dimensionX)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

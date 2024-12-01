import UIKit

public extension UILabel {
    static func build(size: FontSize,
                      weight: FontWeight,
                      textColor: UIColor,
                      alignment: NSTextAlignment = .left,
                      numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.font = UIFont.designFont(size: size, weight: weight)
        label.textColor = textColor
        label.textAlignment = alignment
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

import UIKit

//public enum Fonts: String {
//    case regular = "SFProDisplay-Regular"
//    case bold = "SFProDisplay-Bold"
//    case semiBold = "SFProDisplay-Semibold"
//}

public enum FontWeight {
    case bold,
         regular,
         semiBold
}

public enum FontSize: CGFloat {
    case title = 28,
         title2 = 24,
         title3 = 18,
         title4 = 16,
         subtitle = 14,
         caption = 13
         
}

extension UIFont {
    public static func designFont(size: FontSize, weight: FontWeight) -> UIFont {

        switch weight {
        case .bold:
            return UIFont.systemFont(ofSize: size.rawValue, weight: .bold)
        case .regular:
            return UIFont.systemFont(ofSize: size.rawValue, weight: .regular)
        case .semiBold:
            return UIFont.systemFont(ofSize: size.rawValue, weight: .semibold)
        }
    }
}

import UIKit

public struct Images {
    private static func uiImage(rawValue: String) -> UIImage {
        UIImage(named: rawValue, in: Bundle.module, compatibleWith: nil) ?? .init()
    }
    
    public enum Logo: String {
        case navigationBarLogo
        
        public var uiImage: UIImage {
            Images.uiImage(rawValue: rawValue)
        }
    }
    
    public enum Icon: String {
        case chevronLeft = "ic_chevron-left"
        
        public var uiImage: UIImage {
            Images.uiImage(rawValue: rawValue)
        }
    }
}

import UIKit

public struct Colors {
    private static func uiColor(rawValue: String) -> UIColor {
        UIColor(named: rawValue, in: Bundle.module, compatibleWith: nil) ?? .init()
    }
    
    public enum Background: String {
        case primaryBackground
        
        public var uiColor: UIColor {
            Colors.uiColor(rawValue: rawValue)
        }
    }
    
    public enum Neutral: String {
        case primaryTextColor
        
        public var uiColor: UIColor {
            Colors.uiColor(rawValue: rawValue)
        }
    }
}

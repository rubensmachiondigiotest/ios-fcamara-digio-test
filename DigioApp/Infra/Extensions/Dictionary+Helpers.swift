import Foundation

extension Dictionary {
    
    mutating func append(with: Dictionary<Key, Value>) {
        for (k, v) in with {
            self[k] = v
        }
    }
    
    func queryString(_ dictionary: Dictionary? = nil) -> String {
        let dict = dictionary ?? self
        return dict
            .compactMap { (key, value) -> String? in
                if value is [String: Any] {
                    if let dictionary = value as? Dictionary {
                        return queryString(dictionary)
                    }
                }
                else {
                    return "\(key)=\(value)"
                }
                
                return nil
            }
            .joined(separator: "&")
    }
}

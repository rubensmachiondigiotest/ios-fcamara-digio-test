import UIKit

public extension UIImageView {

    func downloadImageFrom(url: URL,
                           completion: ((Result<UIImage?, Error>) -> Void)? = nil) {
        self.sd_setImage(with: url) { downloadedImage, error, _, _ in
            if let error = error {
                completion?(.failure(error))
            } else {
                completion?(.success(downloadedImage))
            }
        }
    }
}

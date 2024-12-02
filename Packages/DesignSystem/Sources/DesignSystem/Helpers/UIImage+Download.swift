import UIKit

public extension UIImageView {

    func downloadImageFrom(url: URL,
                           completion: ((Result<UIImage?, Error>) -> Void)? = nil) {
        sd_setImage(with: url) { [weak self] downloadedImage, error, _, _ in
            if let error = error {
                self?.image = Images.Icon.noImage.uiImage
                completion?(.failure(error))
            } else {
                completion?(.success(downloadedImage))
            }
        }
    }
}

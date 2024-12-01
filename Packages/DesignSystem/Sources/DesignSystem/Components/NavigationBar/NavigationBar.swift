import UIKit

@MainActor
public struct NavigationBar {
    public static func apply(to viewController: UIViewController,
                             title: String,
                             rightButtonImage: UIImage?,
                             rightButtonAction: Selector?) {
        viewController.title = title

        if let navigationController = viewController.navigationController, navigationController.viewControllers.count > 1 {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Images.Icon.chevronLeft.uiImage,
                                                                              style: .plain,
                                                                              target: viewController,
                                                                              action: #selector(viewController.didTapBackButton))
        }

        if let rightButtonAction = rightButtonAction {
            let rightButton = UIBarButtonItem(image: rightButtonImage,
                                              style: .plain,
                                              target: viewController,
                                              action: rightButtonAction)
            viewController.navigationItem.rightBarButtonItem = rightButton
        }

        if let navigationController = viewController.navigationController {
            navigationController.navigationBar.barTintColor = Colors.Background.primaryBackground.uiColor
            navigationController.navigationBar.tintColor = Colors.Neutral.primaryTextColor.uiColor
            navigationController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: Colors.Neutral.primaryTextColor.uiColor,
                NSAttributedString.Key.font: UIFont.designFont(size: .title3, weight: .bold)
            ]

            navigationController.navigationBar.isTranslucent = true
        }
        
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

extension UIViewController {
    @objc func didTapBackButton() {
        if navigationController?.viewControllers.count == 2 {
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
        navigationController?.popViewController(animated: true)
    }
}

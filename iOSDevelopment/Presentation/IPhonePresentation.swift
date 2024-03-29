import UIKit
import AUIKit

class IPhonePresentation: AUIWindowPresentation, Presentation {
    
    func start() {
        let screenController = MenuScreenViewController()
        screenController.didSelectSignUpScreen = { [weak self, weak screenController] in
            guard let self = self else { return }
            guard let screenController = screenController else { return }
            self.presentSignUpScreenViewController(screenController)
        }
        screenController.didSelectCustomShapeScreen = { [weak self, weak screenController] in
            guard let self = self else { return }
            guard let screenController = screenController else { return }
            self.presentCustomShapeScreenViewController(screenController)
        }
        window.rootViewController = screenController
        window.makeKeyAndVisible()
    }
    
    
    private var presentingSignUpScreenViewController: SignUpScreenController?
    func presentSignUpScreenViewController(_ presentingViewController: UIViewController) {
        let viewController = SignUpScreenController()
        viewController.didCancel = { [weak viewController] in
            guard let viewController = viewController else { return }
            viewController.dismiss(animated: true, completion: nil)
        }
        viewController.modalPresentationStyle = .fullScreen
        presentingSignUpScreenViewController = viewController
        presentingViewController.present(viewController, animated: true, completion: nil)
    }
    
    private var presentingCustomShapeScreenViewController: CustomShapeScreenViewController?
    func presentCustomShapeScreenViewController(_ presentingViewController: UIViewController) {
        let viewController = CustomShapeScreenViewController()
//        viewController.didCancel = { [weak viewController] in
//            guard let viewController = viewController else { return }
//            viewController.dismiss(animated: true, completion: nil)
//        }
//        viewController.modalPresentationStyle = .fullScreen
        presentingCustomShapeScreenViewController = viewController
        presentingViewController.present(viewController, animated: true, completion: nil)
    }
    
}

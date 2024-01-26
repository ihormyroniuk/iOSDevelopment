import UIKit
import AUIKit
import AFoundation

class CustomShapeScreenViewController: UIViewController {

    // MARK: View
    
    override func loadView() {
        view = CustomShapeScreenView()
    }

    private var screenView: CustomShapeScreenView! {
        return self.view as? CustomShapeScreenView
    }
    
}

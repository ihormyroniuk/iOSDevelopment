import UIKit
import AUIKit

class MenuScreenViewController: UIViewController {
    
    // MARK: - Events
    
    var didSelectSignUpScreen: (() -> Void)?
    
    // MARK: View
    
    override func loadView() {
        view = MenuScreenView()
    }
    
    private var menuScreenView: MenuScreenView! {
        return view as? MenuScreenView
    }
    
    // MARK: Componets
    
    let collectionViewController = AUIEmptyCollectionViewController()
    
    // MARK: Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setContent()
    }

    private func setupCollectionView() {
        collectionViewController.collectionView = menuScreenView.collectionView
        let sectionController = AUIEmptyCollectionViewSectionController()
        var cellControllers: [AUICollectionViewCellController] = []
        let signupCellController = AUIClosuresCollectionViewCellController()
        signupCellController.cellForItemAtIndexPathClosure = { [weak self] indexPath in
            guard let self = self else { return UICollectionViewCell() }
            let cell = self.menuScreenView.menuItemCollectionViewCell(indexPath: indexPath)
            cell.titleLabel.text = "Signup"
            return cell
        }
        signupCellController.didSelectClosure = { [weak self] in
            guard let self = self else { return }
            guard let didSelectSignUpScreen = self.didSelectSignUpScreen else { return }
            didSelectSignUpScreen()
        }
        signupCellController.sizeForCellClosure = { [weak self] in
            guard let self = self else { return .zero }
            return self.menuScreenView.menuItemCollectionViewCellSize()
        }
        cellControllers.append(signupCellController)
        sectionController.cellControllers = cellControllers
        collectionViewController.sectionControllers = [sectionController]
    }

    // MARK: Content
    
    private func setContent() {
        //menuScreenView.titleLabel.text = "Menu"
    }
    
}


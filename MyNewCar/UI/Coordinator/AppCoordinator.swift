import UIKit

final class AppCoordinator {
    private let rootNavigationController:UINavigationController
    
    init(navigationController: UINavigationController) {
        self.rootNavigationController = navigationController
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainScreen") as? MainScreen
        rootNavigationController.setViewControllers([vc!], animated: true)
    }
}

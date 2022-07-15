import Resolver
import RxSwift
import UIKit

class MainScreen: UIViewController {
    @Injected private var viewModel: MainViewModel
    
    @IBOutlet weak private var favoriteCountLabel: UILabel!
    @IBOutlet weak private var goToListButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.favoritesCount
            .map { "Count of favorites: \($0)" }
            .bind(to: favoriteCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

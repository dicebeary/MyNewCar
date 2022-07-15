import RxSwift

protocol MainViewModelInterface {
    var favoritesCount: Observable<Int> { get }
}

final class MainViewModel: MainViewModelInterface {
    private let userInteractor: UserInteractorInterface
    
    var favoritesCount: Observable<Int>
    
    init(userInteractor: UserInteractorInterface) {
        self.userInteractor = userInteractor
        
        self.favoritesCount = userInteractor.favorites
            .map(\.count)
    }
}

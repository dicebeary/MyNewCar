import RxSwift

protocol MakeListViewModelInterface {
    var list: Observable<[MakeCellModel]> { get }
    
    func listen(to events: MakeListScreen.Events)
}

final class MakeListViewModel: MakeListViewModelInterface {
    private let makeInteractor: MakeInteractorInterface
    private let userInteractor: UserInteractorInterface
    
    private let disposeBag = DisposeBag()
    
    var list: Observable<[MakeCellModel]>
    
    init(makeInteractor: MakeInteractorInterface,
         userInteractor: UserInteractorInterface) {
        self.makeInteractor = makeInteractor
        self.userInteractor = userInteractor
        
        let makes = makeInteractor.fetchMakes()
        
        self.list = Observable.combineLatest(userInteractor.favorites.asObservable(),
                                             makes.asObservable())
        .map { favorites, makes -> [MakeCellModel] in
            let list = makes.map { make -> MakeCellModel in
                var isFavorite = false
                if favorites.contains(make.id) { isFavorite = true }
                return MakeCellModel(make, isFavorite: isFavorite)
            }
            
            return list
        }
    }
    
    func listen(to events: MakeListScreen.Events) {
        events.favoriteDidTap
            .withLatestFrom(userInteractor.favorites) { return ($0, $1) }
            .subscribe(onNext: { [weak self] favoriteId, favorites in
                guard let self = self else { return }
                if favorites.contains(favoriteId) {
                    self.userInteractor.removeFavorite(by: favoriteId)
                } else {
                    self.userInteractor.saveFavorite(by: favoriteId)
                }
                
            })
            .disposed(by: disposeBag)
    }
}

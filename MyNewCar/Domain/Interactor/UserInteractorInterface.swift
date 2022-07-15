import RxSwift

// sourcery: AutoMockable
/// Interactor for fetching favorites
protocol UserInteractorInterface {
    var favorites: Observable<[String]> { get }
    func saveFavorite(by id: String)
    func removeFavorite(by id: String)
}

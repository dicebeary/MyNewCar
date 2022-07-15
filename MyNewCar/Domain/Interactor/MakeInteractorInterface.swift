import RxSwift

// sourcery: AutoMockable
/// Interactor for fetching makes
protocol MakeInteractorInterface {
    func fetchMakes() -> Single<[Make]>
}

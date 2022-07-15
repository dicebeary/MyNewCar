import RxSwift
import RxCocoa

final class MakeInteractor: MakeInteractorInterface {
    func fetchMakes() -> Single<[Make]> {
        return .just(Make.mock)
    }
}

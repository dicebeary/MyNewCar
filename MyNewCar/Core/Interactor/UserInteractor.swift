import Foundation
import RxSwift
import RxRelay

final class UserInteractor: UserInteractorInterface {
    var favorites: Observable<[String]> {
        return favoritesRelay
            .map { Array($0) }
    }
    var favoritesRelay = BehaviorRelay<Set<String>>(value: [])
    var storage = UserDefaults.standard
    
    init() {
        self.favoritesRelay.accept(Set((storage.object(forKey: "favorites") as? [String]) ?? []))
    }
    
    func saveFavorite(by id: String) {
        var favorites = favoritesRelay.value
        favorites.insert(id)
        self.favoritesRelay.accept(favorites)
        storage.set(Array(favorites), forKey: "favorites")
    }

    func removeFavorite(by id: String) {
        var favorites = favoritesRelay.value
        favorites.remove(id)
        self.favoritesRelay.accept(favorites)
        storage.set(Array(favorites), forKey: "favorites")
    }
}

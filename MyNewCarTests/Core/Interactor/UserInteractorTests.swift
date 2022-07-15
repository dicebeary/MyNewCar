import Nimble
import RxSwift
import RxBlocking
import SwiftyMocky
import XCTest
@testable import MyNewCar

class UserInteractorTests: XCTestCase {
    var sut: UserInteractorInterface!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        sut = nil
        disposeBag = nil
        UserDefaults.standard.removeObject(forKey: "favorites")
        super.tearDown()
    }
}

extension UserInteractorTests {
    func testDefaultFavorites() throws {
        // Arrange
        let givenIds = ["11", "13", "17", "19"]
        UserDefaults.standard.set(givenIds, forKey: "favorites")
        sut = UserInteractor()

        // Act
        var favorites = try sut.favorites.take(1).toBlocking(timeout: 1.0).first()
        
        // Assert
        favorites = favorites?.sorted(by: <)
        expect(favorites).to(equal(givenIds))
    }

    func testSaveFavorites() throws {
        // Arrange
        sut = UserInteractor()
        sut.saveFavorite(by: "test")

        // Act
        let favorites = try sut.favorites.take(1).toBlocking(timeout: 1.0).first()

        // Assert
        expect(favorites?.count).to(equal(1))
        expect(favorites?.first).to(equal("test"))
    }

    func testRemoveFavorites() throws {
        // Arrange
        let givenIds = ["11", "13"]
        UserDefaults.standard.set(givenIds, forKey: "favorites")
        sut = UserInteractor()
        sut.removeFavorite(by: "13")

        // Act
        let favorites = try sut.favorites.take(1).toBlocking(timeout: 1.0).first()

        // Assert
        expect(favorites?.count).to(equal(1))
        expect(favorites?.first).to(equal("11"))
    }
}

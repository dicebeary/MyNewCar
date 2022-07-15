import Nimble
import RxSwift
import RxBlocking
import SwiftyMocky
import XCTest
@testable import MyNewCar

class MainViewModelTests: XCTestCase {
    var userInteractor: UserInteractorInterfaceMock!
    var sut: MainViewModelInterface!

    override func setUp() {
        userInteractor = UserInteractorInterfaceMock()
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        userInteractor = nil
        sut = nil
    }
}

// MARK: - Test cases
extension MainViewModelTests {
    func testIdleState() throws {
        // Arrange
        Given(userInteractor, .favorites(getter: .just([])))

        sut = MainViewModel(userInteractor: userInteractor)

        // Act
        let count = try sut.favoritesCount.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(count).to(equal(0))
    }

    func testIdleStateWithFavorites() throws {
        // Arrange
        Given(userInteractor, .favorites(getter: .just(["11", "14", "15"])))

        sut = MainViewModel(userInteractor: userInteractor)

        // Act
        let count = try sut.favoritesCount.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(count).to(equal(3))
    }
}

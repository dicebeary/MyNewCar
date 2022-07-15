import Nimble
import RxSwift
import RxBlocking
import SwiftyMocky
import XCTest
@testable import MyNewCar

class MakeListViewModelTests: XCTestCase {
    var userInteractor: UserInteractorInterfaceMock!
    var makeInteractor: MakeInteractorInterfaceMock!
    var sut: MakeListViewModelInterface!

    override func setUp() {
        userInteractor = UserInteractorInterfaceMock()
        makeInteractor = MakeInteractorInterfaceMock()
        
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        userInteractor = nil
        makeInteractor = nil
        sut = nil
    }
}

// MARK: - Test cases
extension MakeListViewModelTests {
    func testIdleState() throws {
        // Arrange
        Given(makeInteractor, .fetchMakes(willReturn: .just(MakeObjects.mock)))
        Given(userInteractor, .favorites(getter: .just([])))

        sut = MakeListViewModel(makeInteractor: makeInteractor,
                                userInteractor: userInteractor)

        // Act
        let list = try sut.list.toBlocking(timeout: 1.0).first()
        
        // Assert
        expect(list?.count).to(equal(11))
    }

    func testFavoriteDidTapToSave() throws {
        // Arrange
        Given(makeInteractor, .fetchMakes(willReturn: .just(MakeObjects.mock)))
        Given(userInteractor, .favorites(getter: .just([])))

        sut = MakeListViewModel(makeInteractor: makeInteractor,
                                userInteractor: userInteractor)

        // Act
        sut.listen(to: .init(
            favoriteDidTap: .init(events: Observable<String>.just("10")))
        )
        
        // Assert
        Verify(userInteractor, .saveFavorite(by: .value("10")))
    }

    func testFavoriteDidTapToRemove() throws {
        // Arrange
        Given(makeInteractor, .fetchMakes(willReturn: .just(MakeObjects.mock)))
        Given(userInteractor, .favorites(getter: .just(["10"])))

        sut = MakeListViewModel(makeInteractor: makeInteractor,
                                userInteractor: userInteractor)

        // Act
        sut.listen(to: .init(
            favoriteDidTap: .init(events: Observable<String>.just("10")))
        )
        
        // Assert
        Verify(userInteractor, .removeFavorite(by: .value("10")))
    }
}

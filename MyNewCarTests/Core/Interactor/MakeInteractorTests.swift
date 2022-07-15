import Nimble
import RxSwift
import RxBlocking
import SwiftyMocky
import XCTest
@testable import MyNewCar

class MakeInteractorTests: XCTestCase {
    var sut: MakeInteractorInterface!

    override func setUp() {
        sut = MakeInteractor()
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
}

extension MakeInteractorTests {
    func testFetchMake() throws {
        // Arrange
        let givenFirstMake = "Tesla"

        // Act
        let makes = try sut.fetchMakes().asObservable().toBlocking(timeout: 1.0).first()

        // Assert
        expect(makes?.first?.name).to(equal(givenFirstMake))
    }
}

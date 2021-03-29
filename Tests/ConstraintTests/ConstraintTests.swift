import XCTest
@testable import Constraint

final class ConstraintTests: XCTestCase {
    func testExample() {
        let testView = UIView()
        testView.setNeedsLayout()
        testView.layoutIfNeeded()

        testView.width(50)
        testView.height(20)

        let widthConstraint = testView.constraints.filter { $0.firstAttribute == .width }.first!
        let heightConstraint = testView.constraints.filter { $0.firstAttribute == .height }.first!

        XCTAssertEqual(widthConstraint.constant, 50)
        XCTAssertEqual(heightConstraint.constant, 20)
        XCTAssertTrue(widthConstraint.isActive)
        XCTAssertTrue(heightConstraint.isActive)
    }
}

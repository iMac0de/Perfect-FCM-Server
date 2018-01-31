import XCTest
@testable import Perfect_FCM_Server

class Perfect_FCM_ServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
		PerfectFCM.prepare()
	}


    static var allTests = [
        ("testExample", testExample),
    ]
}

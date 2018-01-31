import XCTest
@testable import Perfect_FCM_Server

class Perfect_FCM_ServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert andz related functions to verify your tests produce the correct
        // results.
        do {
            try PerfectFCM.send(token: "cNiYo3ya7Lk:APA91bGrBY1OURkyD6zf-taMOIyYyx_F54EigWWhltQnsvbCI38iYztVfoGy-PAMNnQunf_hiFF07p--qoukhxCjrtY0yZZUOl-c_mYZLscmLIVJFh1T1sV7dxi8PQsku7PYwR1TQTGo", title: "Hello world!", body: "First PUSH notification!", data: nil)
        } catch {
            print(error.localizedDescription)
        }
	}


    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest
@testable import Perfect_FCM_Server

extension String {
    
    public var sysEnv: String {
        guard let e = getenv(self) else { return "" }
        return String(cString: e)
    }
    
}

class Perfect_FCM_ServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert andz related functions to verify your tests produce the correct
        // results.
        let config = PerfectFCM.Config(serverKey: "FCM_SERVER_KEY".sysEnv)
        
        do {
            try PerfectFCM.send(config, to: "FCM_DEVICE_TOKEN".sysEnv, title: "Hello world!", body: "Perfect FCM PUSH notification!", data: nil)
        } catch {
            print(error.localizedDescription)
        }
	}

    static var allTests = [
        ("testExample", testExample),
    ]
}


#if os(iOS)

import XCTest
import BSWFoundation

class UIApplicationTests: XCTestCase {
    func testItWorks() {
        XCTAssert(UIApplication.shared.isRunningTests)
    }
}

#endif

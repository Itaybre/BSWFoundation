
#if os(iOS)

import XCTest
import BSWFoundation

class UIApplicationTests: XCTestCase {
    @MainActor
    func testItWorks() {
        XCTAssert(UIApplication.shared.isRunningTests)
    }
}

#endif


#if os(iOS)

import UIKit

public extension UIApplication {
    /// If the application is executing Unit Tests.
    @inlinable
    var isRunningTests: Bool {
        #if DEBUG
        return NSClassFromString("XCTest") != nil
        #else
        return false
        #endif
    }
}

#endif

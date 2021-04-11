import XCTest
import UIKit
@testable import ResponderChain

final class ResponderChainTests: XCTestCase {
    func testExample() {
        
        let rootView = UIView()
        
        let subView = UIView()
        
        let subSubView = UIView()
        
        rootView.addSubview(subView)
        subView.addSubview(subSubView)
        
        rootView.responder.register(key: "123") { (value: String) -> Bool in
            print(value)
            return false
        }
        
        subView.responder.register(key: "123") { (value: String) -> Bool in
            print(value)
            return true
        }
        
        subSubView.responder.handler(key: "123", value: 123)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest
import UIKit
@testable import ResponderChain

struct StringKey<Value>: ResponderKeyType {
    let string: String
}

var key123: StringKey<String> = StringKey(string: "123")

final class ResponderChainTests: XCTestCase {
    func testExample() {
        
        let rootView = UIView()
        
        let subView = UIView()
        
        let subSubView = UIView()
        
        rootView.addSubview(subView)
        subView.addSubview(subSubView)
        
        rootView.responder.register(key: key123) { (value: String) -> Bool in
            print(value)
            return false
        }
        
        subView.responder.register(key: key123) { (value: String) -> Bool in
            print(value)
            return true
        }
        
        subSubView.responder.handler(typeKey: key123, value: "123")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}

import XCTest
import UIKit
@testable import ResponderChain

var key123: AnyResponderKey<String> = AnyResponderKey(key: 1)

class NextTest: NextType {
    var next: UIView?
}

extension NextTest : ResponderWrappable {}


final class ResponderChainTests: XCTestCase {
    
    
    func testExample() {
        
        let rootView = UIView()
        
        let subView = UIView()
        
        let subSubView = UIView()
        
        rootView.addSubview(subView)
        subView.addSubview(subSubView)
        
        rootView.rsp.register(key: key123) { (value: String) -> Bool in
            print(value)
            return false
        }
        
        subView.rsp.register(key: key123) { (value: String) -> Bool in
            print(value)
            return true
        }
        
        let nextTest = NextTest()
        nextTest.next = rootView
        
        subSubView.rsp.handler(typeKey: key123, value: "subsubView call")
        nextTest.rsp.handler(typeKey: key123, value: "nextTest call")
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}


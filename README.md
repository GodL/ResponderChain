# ResponderChain

`ResponderChain` is a library that passes events using the responder chain.

In Cocoa's development model, events can be delivered using `delegate`, `block`, and `notification`.
Usually a delegate or block is used to pass events between a `ViewController` and a `View`, However, when a deep nested `view` needs to pass events to the `ViewController`, using a delegate or block might require passing them layer by layer. Now, events can be passed in one step, regardless of how deep the view hierarchy is, using the `ResponderChain`.

## Installation

### Swift Package Manager
[Swift Package Manager](https://swift.org/package-manager/) is Apple's decentralized dependency manager to integrate libraries to your Swift projects. It is now fully integrated with Xcode 11

To integrate `ResponderChain` into your project using SPM, specify it in your `Package.swift` file:

```swift
let package = Package(
    …
    dependencies: [
        .package(url: "https://github.com/GodL/ResponderChain.git", from: "1.0.4"),
    ],
    targets: [
        .target(name: "YourTarget", dependencies: ["ResponderChain", …])
        …
    ]
)
```

### Cocoapods

``` ruby
pod 'GLResponderChain', '~> 1.0.4'
```

## Usage

```swift
let rootView = UIView()

let subView = UIView()

let subSubView = UIView()

rootView.addSubview(subView)
subView.addSubview(subSubView)

```
### normal

```swift

rootView.rsp.register(key: “123”) { (value: String) -> Bool in
    XCTAssertEqual(value, "123")
    return false
}

subView.rsp.register(key: ”123) { (value: String) -> Bool in
    XCTAssertEqual(value, "123")
    return true
}

subSubView.rsp.handler(key: “123”, value: "123")
```

### type-safe

```swift

var key123: ResponderKey<String> = ResponderKey(value: "123")

rootView.rsp.register(typeKey: key123) { (value: String) -> Bool in
    XCTAssertEqual(value, "123")
    return false
}

subView.rsp.register(typeKey: key123) { (value: String) -> Bool in
    XCTAssertEqual(value, "123")
    return true
}

subSubView.rsp.handler(typeKey: key123, value: "123")
```
## Author

GodL, 547188371@qq.com. Github [GodL](https://github.com/GodL)

*I am happy to answer any questions you may have. Just create a [new issue](https://github.com/GodL/ResponderChain/issues/new).*

## License

MIT License

Copyright (c) 2021 GodL

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

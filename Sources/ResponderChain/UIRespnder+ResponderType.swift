//
//  UIResponder+ResponderType.swift
//  
//
//  Created by GodL on 2021/4/5.
//

import UIKit

private var key: String = ""

extension Responder where Base : UIResponder {
    fileprivate var responderHandlers: [AnyHashable : (ResponderValue) -> Bool]? {
        nonmutating set {
            objc_setAssociatedObject(self.base, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let handlers = objc_getAssociatedObject(self.base, &key) as? [AnyHashable : (ResponderValue) -> Bool] else { return nil }
            return handlers
        }
    }
    
    fileprivate func _initResponderHandlers() {
        if self.responderHandlers == nil {
            self.responderHandlers = [:]
        }
    }
}

extension Responder where Base : UIResponder {
    public func register<Key: Hashable, Value>(key: Key, handler: @escaping (Value) -> Bool) {
        let key = AnyHashable(key)
        _initResponderHandlers()
        self.responderHandlers?[key] = {
            handler($0.get())
        }
    }
}


extension Responder where Base : UIResponder {
    public func handler<Key: Hashable, Value>(key: Key, value: Value) {
        _handler(responder: self.base.next, key: key, value: value)
    }
    
    private func _handler<Key: Hashable, Value>(responder: UIResponder?, key: Key, value: Value) {
        if let responder = responder, let handlers = responder.responder.responderHandlers {
            if let handler = handlers[key], handler(ResponderValue(value)) {
                _handler(responder: responder.next, key: key, value: value)
            }
        }
    }
}

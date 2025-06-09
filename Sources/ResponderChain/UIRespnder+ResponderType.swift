//
//  UIResponder+ResponderType.swift
//  
//
//  Created by GodL on 2021/4/5.
//

import UIKit

@MainActor
private var key: UInt8 = 0

extension NextType {
    fileprivate var responderHandlers: [AnyHashable : (ResponderValue) -> Bool]? {
        nonmutating set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let handlers = objc_getAssociatedObject(self, &key) as? [AnyHashable : (ResponderValue) -> Bool] else { return nil }
            return handlers
        }
    }
    
    fileprivate func _initResponderHandlers() {
        if self.responderHandlers == nil {
            self.responderHandlers = [:]
        }
    }
}

@MainActor
extension Responder where Base : NextType {
    
    /// Registers a handler for the current responder.
    /// - Parameters:
    ///   - key: Event key, which identifies a handler
    ///   - handler: The callback corresponding to the event,The return value represents whether to proceed to the next responder. `YES` means proceed to the next responder.
    public func register<Key: Hashable, Value>(key: Key, handler: @escaping (Value) -> Bool) {
        let key = AnyHashable(key)
        self.base._initResponderHandlers()
        self.base.responderHandlers?[key] = {
            handler($0.get())
        }
    }
    
    /// Register a handler for the current responder in a type-safe manner.
    /// - Parameters:
    ///   - typeKey: Event key, which identifies a handler,Contains a generic parameter
    ///   - handler: The callback corresponding to the event,The return value represents whether to proceed to the next responder. `YES` means proceed to the next responder.
    public func register<Key: ResponderKeyType, Value>(typeKey: Key, handler: @escaping (Value) -> Bool) where Key.Value == Value {
        let key = AnyHashable(typeKey)
        self.base._initResponderHandlers()
        self.base.responderHandlers?[key] = {
            handler($0.get())
        }
    }
}

@MainActor
extension Responder where Base : NextType {
    
    /// Send an event
    /// - Parameters:
    ///   - key: Event key, which identifies a handler
    ///   - value: The parameters passed by the event
    public func handler<Key: Hashable, Value>(key: Key, value: Value) {
        _handler(responder: self.base.next, key: key, value: value)
    }
    
    /// Send an event in a type-safe manner.
    /// - Parameters:
    ///   - typeKey: Event key, which identifies a handler,Contains a generic parameter
    ///   - value: The parameters passed by the event
    public func handler<Key: ResponderKeyType, Value>(typeKey: Key, value: Value) where Key.Value == Value {
        _handler(responder: self.base.next, key: typeKey, value: value)
    }
    
    private func _handler<Key: Hashable, Value, Next: NextType>(responder: Next?, key: Key, value: Value) {
        if let responder = responder {
            if let handlers = responder.responderHandlers {
                if let handler = handlers[key] {
                    if handler(ResponderValue(value)) {
                        _handler(responder: responder.next, key: key, value: value)
                    }
                }else {
                    _handler(responder: responder.next, key: key, value: value)
                }
            }else {
                _handler(responder: responder.next, key: key, value: value)
            }
        }
    }
}

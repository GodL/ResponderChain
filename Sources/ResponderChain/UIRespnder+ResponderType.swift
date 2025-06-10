//
//  UIResponder+ResponderType.swift
//  
//
//  Created by GodL on 2021/4/5.
//

import Foundation

@MainActor
private var responderHandlerskey: UInt8 = 0

@MainActor
private var responderResultHandlersKey: UInt8 = 0

extension NextType {
    fileprivate var responderHandlers: [AnyHashable : (ResponderValue) -> Bool]? {
        nonmutating set {
            objc_setAssociatedObject(self, &responderHandlerskey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &responderHandlerskey) as? [AnyHashable : (ResponderValue) -> Bool]
        }
    }
    
    fileprivate func _initResponderHandlers() {
        if self.responderHandlers == nil {
            self.responderHandlers = [:]
        }
    }
    
    fileprivate var responderResultHandlers: [AnyHashable : (ResponderValue) -> Any]? {
        nonmutating set {
            objc_setAssociatedObject(self, &responderResultHandlersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &responderResultHandlersKey) as? [AnyHashable : (ResponderValue) -> Any]
        }
    }
    
    fileprivate func _initResponderResultHandlers() {
        if self.responderResultHandlers == nil {
            self.responderResultHandlers = [:]
        }
    }
}

@MainActor
extension ResponderChain where Base : NextType {
    
    /// Registers a handler for the current responder.
    /// - Parameters:
    ///   - key: Event key, which identifies a handler
    ///   - handler: The callback corresponding to the event,The return value represents whether to proceed to the next responder. `YES` means proceed to the next responder.
    public func register<Key: Hashable, Value>(key: Key, handler: sending @MainActor @escaping (Value) -> Bool) {
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
    public func register<Key: ResponderKeyType, Value>(typeKey: Key, handler: sending @MainActor @escaping (Value) -> Bool) where Key.Value == Value, Key.Result == Bool {
        let key = AnyHashable(typeKey)
        self.base._initResponderHandlers()
        self.base.responderHandlers?[key] = {
            handler($0.get())
        }
    }
}

@MainActor
extension ResponderChain where Base : NextType {
    public func registerValue<Key: Hashable, Value, Result>(key: Key, handler: sending @MainActor @escaping (Value) -> Result) {
        let key = AnyHashable(key)
        self.base._initResponderResultHandlers()
        self.base.responderResultHandlers?[key] = {
            handler($0.get())
        }
    }
    
    public func registerValue<Key: ResponderKeyType, Value, Result>(typeKey: Key, handler: sending @MainActor @escaping (Value) -> Result ) where Key.Value == Value, Key.Result == Result {
        let key = AnyHashable(typeKey)
        self.base._initResponderResultHandlers()
        self.base.responderResultHandlers?[key] = {
            handler($0.get())
        }
    }
}

@MainActor
extension ResponderChain where Base : NextType {
    
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
    public func handler<Key: ResponderKeyType, Value>(typeKey: Key, value: Value) where Key.Value == Value, Key.Result == Bool {
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

@MainActor
extension ResponderChain where Base : NextType {
    public func value<Key: Hashable, Value, Result>(key: Key, value: Value) -> Result? {
        _value(responder: self.base.next, key: key, value: value)
    }
    
    public func value<Key: ResponderKeyType, Value, Result>(typeKey: Key, value: Value) -> Result? where Key.Value == Value, Key.Result == Result {
        _value(responder: self.base.next, key: typeKey, value: value)
    }
    
    private func _value<Key: Hashable, Value, Result, Next: NextType>(responder: Next?, key: Key, value: Value) -> Result? {
        if let responder {
            if let handlers = responder.responderResultHandlers {
                if let handler = handlers[key] {
                    if let result = handler(ResponderValue(value)) as? Result {
                        return result
                    }else {
                        assert(false, "ResponderChain get value failed, Result type is not matched")
                    }
                }else {
                    return _value(responder: responder.next, key: key, value: value)
                }
            }else {
                return _value(responder: responder.next, key: key, value: value)
            }
        }
        return nil
    }
}

//
//  ResponderValue.swift
//  
//
//  Created by GodL on 2021/4/10.
//

internal struct ResponderValue {
    let _value: () -> Any
    
    internal init<Value>(_ value: Value) {
        _value = {
            return value
        }
    }
    
    internal func get<Value>() -> Value {
        guard let value = _value() as? Value else { fatalError() }
        return value
    }
}

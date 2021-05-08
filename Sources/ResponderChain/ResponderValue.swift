//
//  ResponderValue.swift
//  
//
//  Created by GodL on 2021/4/10.
//

public struct ResponderValue {
    let _value: () -> Any
    
    public init<Value>(_ value: Value) {
        _value = {
            return value
        }
    }
    
    public func get<Value>() -> Value {
        guard let value = _value() as? Value else { fatalError() }
        return value
    }
}

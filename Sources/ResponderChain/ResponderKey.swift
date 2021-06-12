//
//  ResponderKey.swift
//  
//
//  Created by GodL on 2021/4/11.
//

public protocol ResponderKeyType : Hashable {
    associatedtype Value
}

public struct AnyResponderKey<Value> : ResponderKeyType {
    
    let key: AnyHashable
    
    public init<Key: Hashable>(key: Key) {
        self.key = AnyHashable(key)
    }
}

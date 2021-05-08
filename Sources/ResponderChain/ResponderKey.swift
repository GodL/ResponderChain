//
//  ResponderKey.swift
//  
//
//  Created by GodL on 2021/4/11.
//

public protocol ResponderKeyType : Hashable {
    associatedtype Value
}

public struct AnyResponderKey<Key: Hashable> : ResponderKeyType {
    public typealias Value = Key
    
    let key: Key
    
    public init(key: Key) {
        self.key = key
    }
}

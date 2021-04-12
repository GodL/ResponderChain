//
//  ResponderKey.swift
//  
//
//  Created by GodL on 2021/4/11.
//

public protocol ResponderKeyType : Hashable {
    associatedtype Value
}

public struct ResponderKey<Value> : ResponderKeyType {
    public static func == (lhs: ResponderKey<Value>, rhs: ResponderKey<Value>) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
        
    let _hash: (inout Hasher) -> Void
    
    public init<Hash: Hashable>(value: Hash) {
        _hash = {
            value.hash(into: &$0)
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        _hash(&hasher)
    }
}

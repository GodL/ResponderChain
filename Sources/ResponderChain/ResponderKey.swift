//
//  ResponderKey.swift
//  
//
//  Created by GodL on 2021/4/11.
//

public protocol ResponderKeyType : Hashable {
    associatedtype Value : Sendable
    
    associatedtype Result : Sendable
}

public struct AnyResponderKey<Value> : ResponderKeyType, @unchecked Sendable {
    
    public typealias Result = Bool
    
    let key: AnyHashable
    
    public init<Key: Hashable>(key: Key) {
        self.key = AnyHashable(key)
    }
}

extension AnyResponderKey : ExpressibleByIntegerLiteral {
    @inlinable
    @inline(__always)
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(key: value)
    }
}

extension AnyResponderKey : ExpressibleByStringLiteral {
    @inlinable
    @inline(__always)
    public init(stringLiteral value: StringLiteralType) {
        self.init(key: value)
    }
}

public struct AnyResponderResultKey<Value, Result> : ResponderKeyType, @unchecked Sendable {
    let key: AnyHashable
    
    public init<Key: Hashable>(key: Key) {
        self.key = AnyHashable(key)
    }
}

extension AnyResponderResultKey : ExpressibleByIntegerLiteral {
    @inlinable
    @inline(__always)
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(key: value)
    }
}

extension AnyResponderResultKey : ExpressibleByStringLiteral {
    @inlinable
    @inline(__always)
    public init(stringLiteral value: StringLiteralType) {
        self.init(key: value)
    }
}

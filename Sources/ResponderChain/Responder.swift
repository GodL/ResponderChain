//
//  Responder.swift
//  
//
//  Created by GodL on 2021/4/4.
//

public struct ResponderChain<Base> {
    let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ResponderWrappable {
    associatedtype WrapperValue
    
    var rsp: ResponderChain<WrapperValue> { get }
}

extension ResponderWrappable {
    public var rsp: ResponderChain<Self> {
        ResponderChain(self)
    }
}

extension Responder: ResponderWrappable {}


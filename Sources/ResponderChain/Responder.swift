//
//  Responder.swift
//  
//
//  Created by GodL on 2021/4/4.
//

import UIKit

public struct Responder<Base> {
    let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ResponderWrappable {
    associatedtype WrapperValue
    
    var responder: Responder<WrapperValue> { get }
}

extension ResponderWrappable {
    public var responder: Responder<Self> {
        Responder(self)
    }
}

extension UIResponder: ResponderWrappable {}



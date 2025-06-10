//
//  NextType.swift
//  
//
//  Created by GodL on 2021/7/11.
//

@MainActor
public protocol NextType : Sendable {
    associatedtype Next: NextType & AnyObject & Sendable
    
    var next: Next? { get }
}
#if os(iOS)
import UIKit.UIResponder

public typealias Responder = UIResponder

#elseif os(macOS)
import AppKit.NSResponder

public typealias Responder = NSResponder

#endif

extension Responder : @retroactive Sendable {}
extension Responder : NextType {
    #if os(macOS)
    @inlinable
    @inline(__always)
    public var next: Responder? {
        nextResponder
    }
    #endif
}

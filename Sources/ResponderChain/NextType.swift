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

import UIKit.UIResponder

extension UIResponder: @retroactive Sendable {}
extension UIResponder : NextType {}

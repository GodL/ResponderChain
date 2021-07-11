//
//  NextType.swift
//  
//
//  Created by GodL on 2021/7/11.
//

public protocol NextType {
    associatedtype Next: NextType & AnyObject
    
    var next: Next? { get }
}

import UIKit.UIResponder

extension UIResponder : NextType {}

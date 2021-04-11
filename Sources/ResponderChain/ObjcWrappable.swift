//
//  ObjcWrappable.swift
//  
//
//  Created by GodL on 2021/4/11.
//
import UIKit

extension UIResponder {
    @objc public func responder_register(key: String, handler: @escaping (Any) -> Bool) {
        self.responder.register(key: key, handler: handler)
    }
    
    @objc public func responder_handler(key: String, value: Any) {
        self.responder.handler(key: key, value: value)
    }
}

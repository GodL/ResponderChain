//
//  ObjcWrappable.swift
//  
//
//  Created by GodL on 2021/4/11.
//
import UIKit

extension UIResponder {
    @objc public func rsp_register(key: String, handler: @escaping (Any) -> Bool) {
        self.rsp.register(key: key, handler: handler)
    }
    
    @objc public func rsp_handler(key: String, value: Any) {
        self.rsp.handler(key: key, value: value)
    }
}

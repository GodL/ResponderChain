//
//  ObjcWrappable.swift
//  
//
//  Created by GodL on 2021/4/11.
//

import Foundation

extension Responder {
    @objc public func rsp_register(key: String, handler: sending @MainActor @escaping (Any) -> Bool) {
        self.rsp.register(key: key, handler: handler)
    }
    
    @objc public func rsp_handler(key: String, value: Any) {
        self.rsp.handler(key: key, value: value)
    }
}

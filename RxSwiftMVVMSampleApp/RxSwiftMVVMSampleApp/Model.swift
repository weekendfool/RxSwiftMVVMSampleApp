//
//  Model.swift
//  RxSwiftMVVMSampleApp
//
//  Created by Oh!ara on 2022/05/24.
//

import Foundation

protocol ModelProtocol {
    func isEnableEmail(email: String) -> Bool
    func plusName(word: String) -> String
}


final class Model: ModelProtocol {
    
    func isEnableEmail(email: String) -> Bool {
        let args = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let validation = NSPredicate(format: "SELF MATCHES %@", args)
        
        return validation.evaluate(with: email)
    }
    
    func plusName(word: String) -> String {
        return word + "Augmented Reality"
    }
}

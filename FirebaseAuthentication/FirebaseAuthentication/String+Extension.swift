//
//  String+Extension.swift
//  FirebaseAuthentication
//
//  Created by Christopher Becom on 6/24/18.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return predicate.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regex = "[A-Z0-9a-z]{5,}$" // characters + digits
//        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{5,}$" // characters + digits + characters
        let predicate = NSPredicate(format:"SELF MATCHES[c] %@", regex)
        return predicate.evaluate(with: self)
    }
}

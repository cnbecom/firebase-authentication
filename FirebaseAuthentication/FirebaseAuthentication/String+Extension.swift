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
}

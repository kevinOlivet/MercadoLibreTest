//
//  TextValidation.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 9/27/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol TextValidationProtocol {
    var regExFindMatchString: String { get }
    var validationMessage: String { get }
}

extension TextValidationProtocol {

    var regExMatchingString: String {
        get {
            return regExFindMatchString + "$"
        }
    }
    
    func validateString(str: String) -> Bool {
        // 3 ways to validate
        // 1
        guard let regex = try? NSRegularExpression(pattern: regExMatchingString, options: []) else {
            return false
        }
        let range = NSRange(str.startIndex..., in: str)
        return regex.firstMatch(in: str, options: [], range: range) != nil
        
        // 2
//        let stringTest = NSPredicate(format: "SELF MATCHES %@", regExMatchingString)
//        return stringTest.evaluate(with: str)
        
        // 3
//        if let _ = str.range(of: regExMatchingString, options: .regularExpression) {
//            return true
//        } else {
//            return false
//        }
    }
    
    func getMatchingString(str: String) -> String? {
        if let newMatch = str.range(of: regExFindMatchString, options: .regularExpression) {
            return String(str[newMatch])
        } else {
            return nil
        }
    }
}

class NumericValidation: TextValidationProtocol {
    static let sharedInstance = NumericValidation()
    private init(){}
    
    var regExFindMatchString: String = "^[0-9]{0,6}"
    
    var validationMessage: String = "You've exceeded the limit".localized()
}

//
//  PaymentMethodRepoMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class PaymentMethodRepoMock: PaymentMethodRepoProtocol {
    var getPaymentMethodsCalled = false
    func getPaymentMethods(successCompletion: @escaping ([PaymentMethodModel]?) -> Void,
                           failureCompletion: @escaping (String) -> Void) {
        getPaymentMethodsCalled = true
    }
    var downloadImageCalled = false
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void) {
        downloadImageCalled = true
    }
}

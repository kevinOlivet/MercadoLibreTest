//
//  BankSelectRepoMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class BankSelectRepoMock: BankSelectRepoProtocol {
    var getBankSelectCalled = false
    func getBankSelect(selectedPaymentMethodId: String,
                       successCompletion: @escaping ([BankSelectModel]?) -> Void,
                       failureCompletion: @escaping (String) -> Void) {
        getBankSelectCalled = true
    }
    var downloadImageCalled = false
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void) {
        downloadImageCalled = true
    }
}

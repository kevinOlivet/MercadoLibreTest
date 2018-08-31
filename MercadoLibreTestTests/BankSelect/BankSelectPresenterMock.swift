//
//  BankSelectPresenterMock.swift
//  MercadoLibreTestTests
//
//  Created by Jon Olivet on 8/30/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation
@testable import MercadoLibreTest

class BankSelectPresenterMock: BankSelectPresenterProtocol {

    var bankSelectModelArray: [BankSelectModel] = [BankSelectModel(name: "test",
                                                                   bankId: "test",
                                                                   secureThumbnail: "test"),
                                                   BankSelectModel(name: "test2",
                                                                   bankId: "test2",
                                                                   secureThumbnail: "test2")]

    var amountEntered: Int? = 25

    var selectedPaymentMethod: PaymentMethodModel? = PaymentMethodModel(name: "test",
                                                                        paymentId: "test",
                                                                        secureThumbnail: "test",
                                                                        paymentTypeId: "test",
                                                                        minAllowedAmount: 5,
                                                                        maxAllowedAmount: 50)

    var getBankSelectCalled = false
    func getBankSelect(successCompletion: @escaping ([BankSelectModel]?) -> Void,
                       failureCompletion: @escaping (String) -> Void) {
        getBankSelectCalled = true
        showErrorAlert(error: "test")
    }
    var downloadImageCalled = false
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void) {
        downloadImageCalled = true
    }
    var showErrorAlertCalled = false
    func showErrorAlert(error: String) {
        showErrorAlertCalled = true
    }
    var handleDidSelectItemCalled = false
    func handleDidSelectItem(indexPathItem: Int) {
        handleDidSelectItemCalled = true
    }
}

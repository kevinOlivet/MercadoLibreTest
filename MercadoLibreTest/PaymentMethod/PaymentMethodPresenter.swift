//
//  PaymentMethodPresenter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol PaymentMethodPresenterProtocol {
    func getPaymentMethods(successCompletion: @escaping ([PaymentMethodModel]?) -> Void,
                           failureCompletion: @escaping (String) -> Void)
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void)
    func showErrorAlert(error: String)
    func handleDidSelectRow(indexPathRow: Int)

    var paymentMethodArray: [PaymentMethodModel] { get set }
    var amountEntered: Int? { get set }
}

class PaymentMethodPresenter: PaymentMethodPresenterProtocol {

    var paymentMethodArray = [PaymentMethodModel]()
    var amountEntered: Int?

    weak var view: PaymentMethodViewControllerProtocol?
    var router: PaymentMethodRouterProtocol
    var repo: PaymentMethodRepoProtocol
    
    init(view: PaymentMethodViewControllerProtocol,
         router: PaymentMethodRouterProtocol,
         repo: PaymentMethodRepoProtocol) {
        self.view = view
        self.router = router
        self.repo = repo
    }

    func getPaymentMethods(successCompletion: @escaping ([PaymentMethodModel]?) -> Void,
                           failureCompletion: @escaping (String) -> Void) {
        repo.getPaymentMethods(successCompletion: { [weak self] (receivedPaymentMethods) in
            if let receivedPaymentMethods = receivedPaymentMethods {
                for method in receivedPaymentMethods {
                    if method.paymentTypeId == "credit_card" {
                        self?.paymentMethodArray.append(method)
                    }
                }
                successCompletion(self?.paymentMethodArray)
            }
        }) { (error) in
            failureCompletion(error)
        }
    }
    
    func handleDidSelectRow(indexPathRow: Int) {
        let selectedPaymentMethod = paymentMethodArray[indexPathRow]
        if let amountEntered = amountEntered {
            if Double(amountEntered) > selectedPaymentMethod.minAllowedAmount && Double(amountEntered) < selectedPaymentMethod.maxAllowedAmount {
                router.showBankSelect(amountEntered: amountEntered,
                                      selectedPaymentMethod: selectedPaymentMethod)
            } else {
                router.showWrongAmountAlert(name: selectedPaymentMethod.name,
                                            minAmount: selectedPaymentMethod.minAllowedAmount,
                                            maxAmount: selectedPaymentMethod.maxAllowedAmount)
            }
        }
    }

    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void) {
        repo.downloadImage(urlString: urlString) { (data) in
            completion(data)
        }
    }

    func showErrorAlert(error: String) {
        router.showErrorAlert(error: error)
    }
}

//
//  BankSelectPresenter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol BankSelectPresenterProtocol {
    func getBankSelect(successCompletion: @escaping ([BankSelectModel]?) -> Void,
                       failureCompletion: @escaping (String) -> Void)
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void)
    func showErrorAlert(error: String)
    func handleDidSelectItem(indexPathItem: Int)

    var bankSelectModelArray: [BankSelectModel] { get set }
    var amountEntered: Int? { get set }
    var selectedPaymentMethod: PaymentMethodModel? { get set }
}

class BankSelectPresenter: BankSelectPresenterProtocol {

    var amountEntered: Int?
    var selectedPaymentMethod: PaymentMethodModel?
    var bankSelectModelArray = [BankSelectModel]()

    weak var view: BankSelectViewControllerProtocol?
    var router: BankSelectRouterProtocol
    var repo: BankSelectRepoProtocol

    init(view: BankSelectViewControllerProtocol,
         router: BankSelectRouterProtocol,
         repo: BankSelectRepoProtocol) {
        self.view = view
        self.router = router
        self.repo = repo
    }

    func getBankSelect(successCompletion: @escaping ([BankSelectModel]?) -> Void,
                       failureCompletion: @escaping (String) -> Void) {
        if let selectedPaymentMethod = selectedPaymentMethod {
            repo.getBankSelect(selectedPaymentMethodId: selectedPaymentMethod.paymentId,
                               successCompletion: { [weak self] (receivedBankSelectModels) in
                                if let receivedBankSelectModels = receivedBankSelectModels {
                                    self?.bankSelectModelArray = receivedBankSelectModels
                                    successCompletion(self?.bankSelectModelArray)
                                }
            }) { (error) in
                failureCompletion(error)
            }
        }
    }

    func handleDidSelectItem(indexPathItem: Int) {
        let bankSelected = (bankSelectModelArray.count > 0) ? bankSelectModelArray[indexPathItem] : nil
        if let amountEntered = amountEntered, let selectedPaymentMethod = selectedPaymentMethod {
            router.showCuotas(amountEntered: amountEntered,
                              selectedPaymentMethod: selectedPaymentMethod,
                              bankSelected: bankSelected)
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

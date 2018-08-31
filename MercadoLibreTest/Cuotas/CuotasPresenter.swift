//
//  CuotasPresenter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol CuotasPresenterProtocol {
    func getCuotas(successCompletion: @escaping ([CuotasModel]?) -> Void,
                   failureCompletion: @escaping (String) -> Void)
    func showErrorAlert(error: String)
    func handleDidSelectRow(indexPathRow: Int)

    var cuotasModelArray: [CuotasModel] { get set }
    var amountEntered: Int? { get set }
    var selectedPaymentMethod: PaymentMethodModel? { get set }
    var bankSelected: BankSelectModel? { get set }
}

class CuotasPresenter: CuotasPresenterProtocol {

    var cuotasModelArray = [CuotasModel]()
    var amountEntered: Int?
    var selectedPaymentMethod: PaymentMethodModel?
    var bankSelected: BankSelectModel?

    weak var view: CuotasViewControllerProtocol?
    var router: CuotasRouterProtocol
    var repo: CuotasRepoProtocol

    init(view: CuotasViewControllerProtocol,
         router: CuotasRouterProtocol,
         repo: CuotasRepoProtocol) {
        self.view = view
        self.router = router
        self.repo = repo
    }
    
    func getCuotas(successCompletion: @escaping ([CuotasModel]?) -> Void,
                   failureCompletion: @escaping (String) -> Void) {
        
        let bankSelectedId = (bankSelected != nil) ? bankSelected!.bankId :  ""
        if let amountEntered = amountEntered, let selectedPaymentMethod = selectedPaymentMethod {
            repo.getCuotas(amountEntered: amountEntered,
                           selectedPaymentMethodId: selectedPaymentMethod.paymentId,
                           bankSelectedId: bankSelectedId,
                           successCompletion: { [weak self] (cuotas) in
                            if let cuotas = cuotas {
                                self?.cuotasModelArray = cuotas
                                successCompletion(self?.cuotasModelArray)
                            }
            }) { (error) in
                failureCompletion(error)
            }
        }
    }

    func handleDidSelectRow(indexPathRow: Int) {
        if let amountEntered = amountEntered, let  selectedPaymentMethod = selectedPaymentMethod {
        let bankSelectedName = (bankSelected != nil) ? bankSelected!.name : selectedPaymentMethod.name
            let finalMessage = "Amount: $\(amountEntered)\n"
                + "Selected Payment Method: \(selectedPaymentMethod.name)\n"
                + "Bank Selected: \(bankSelectedName)\n"
                + cuotasModelArray[indexPathRow].recommendedMessage
            NotificationCenter.default.post(name: Notification.Name(rawValue: "cuotasFinishedNotification"),
                                            object: nil,
                                            userInfo: ["finalMessage": finalMessage])
        }
    }

    func showErrorAlert(error: String) {
        router.showErrorAlert(error: error)
    }
}

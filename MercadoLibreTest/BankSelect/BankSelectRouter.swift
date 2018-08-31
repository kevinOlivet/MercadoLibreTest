//
//  BankSelectRouter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol BankSelectRouterProtocol {
    func showCuotas(amountEntered: Int,
                    selectedPaymentMethod: PaymentMethodModel,
                    bankSelected: BankSelectModel?)
    func showErrorAlert(error: String)
}

class BankSelectRouter: BankSelectRouterProtocol {

    weak var view: BankSelectViewController?

    init(view: BankSelectViewController) {
        self.view = view
    }

    func showCuotas(amountEntered: Int,
                    selectedPaymentMethod: PaymentMethodModel,
                    bankSelected: BankSelectModel?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cuotasViewController = storyboard.instantiateViewController(withIdentifier: "CuotasViewController") as! CuotasViewController
        cuotasViewController.presenter.amountEntered = amountEntered
        cuotasViewController.presenter.selectedPaymentMethod = selectedPaymentMethod
        cuotasViewController.presenter.bankSelected = bankSelected
        view?.navigationController?.pushViewController(cuotasViewController,
                                                       animated: true)
    }

    func showErrorAlert(error: String) {
        if let view = view {
            Alerts.dismissableAlert(title: "Error".localized(),
                                    message: error,
                                    vc: view,
                                    actionBtnText: "Cancel".localized())
        }
    }
}

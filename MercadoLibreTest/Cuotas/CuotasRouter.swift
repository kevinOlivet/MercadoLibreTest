//
//  CuotasRouter.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol CuotasRouterProtocol {
    func showErrorAlert(error: String)
}

class CuotasRouter: CuotasRouterProtocol {

    weak var view: CuotasViewController?

    init(view: CuotasViewController) {
        self.view = view
    }

    func showErrorAlert(error: String) {
        if let view = view {
            Alerts.dismissableAlert(title: "Error".localized(),
                                    message: error,
                                    vc: view,
                                    handler: nil,
                                    actionBtnText: "Ok".localized(),
                                    showCancelButton: true) { (_) in
            }
        }
    }
}

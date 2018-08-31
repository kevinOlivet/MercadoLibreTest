//
//  CuotasRepo.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol CuotasRepoProtocol {
    func getCuotas(amountEntered: Int,
                   selectedPaymentMethodId: String,
                   bankSelectedId: String,
                   successCompletion: @escaping ([CuotasModel]?) -> Void,
                   failureCompletion: @escaping (String) -> Void)
}

extension Networker: CuotasRepoProtocol {

    func getCuotas(amountEntered: Int,
                   selectedPaymentMethodId: String,
                   bankSelectedId: String,
                   successCompletion: @escaping ([CuotasModel]?) -> Void,
                   failureCompletion: @escaping (String) -> Void) {

        let url = "https://api.mercadopago.com/v1/payment_methods/installments?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&amount=\(amountEntered)&payment_method_id=\(selectedPaymentMethodId)&issuer.id=\(bankSelectedId)"

        var cuotaModelArray: [CuotasModel] = []

        guard let urlStable = URL(string: url) else { return }
        let request = URLRequest(url: urlStable)

        let task = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            guard error == nil else {
                failureCompletion(error!.localizedDescription)
                return }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                failureCompletion("statusCode mishap: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return }
            guard let data = data else {
                failureCompletion("Error with data".localized())
                return }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject] {
                    for dict in json {
                        let cast = dict as! [String: AnyObject]
                        let payerCosts = cast["payer_costs"] as! [AnyObject]
                        for cost in payerCosts {
                            let costCast = cost as! [String: AnyObject]
                            guard let installments = costCast["installments"] as? Int else { return }
                            guard let recommendedMessage = costCast["recommended_message"] as? String else { return }
                            let cuota = CuotasModel(installments: installments,
                                                    recommendedMessage: recommendedMessage)
                            cuotaModelArray.append(cuota)
                        }
                    }
                    DispatchQueue.main.async {
                        successCompletion(cuotaModelArray)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    failureCompletion(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

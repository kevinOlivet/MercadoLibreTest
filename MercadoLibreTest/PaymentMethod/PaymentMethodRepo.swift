//
//  PaymentMethodRepo.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol PaymentMethodRepoProtocol {
    func getPaymentMethods(successCompletion: @escaping ([PaymentMethodModel]?) -> Void,
                           failureCompletion: @escaping (String) -> Void)
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void)
}

extension Networker: PaymentMethodRepoProtocol {

    func getPaymentMethods(successCompletion: @escaping ([PaymentMethodModel]?) -> Void,
                           failureCompletion: @escaping (String) -> Void) {

        let url = "https://api.mercadopago.com/v1/payment_methods?public_key=444a9ef5-8a6b-429f-abdf-587639155d88"

        var paymentMethodArray: [PaymentMethodModel] = []
        
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
                        guard let name = dict["name"] as? String else { return }
                        guard let paymentId = dict["id"] as? String else { return }
                        guard let secureThumbnail = dict["secure_thumbnail"] as? String else { return }
                        guard let paymentTypeId = dict["payment_type_id"] as? String else { return }
                        guard let minAllowedAmount = dict["min_allowed_amount"] as? Double else { return }
                        guard let maxAllowedAmount = dict["max_allowed_amount"] as? Double else { return }
                        let paymentMethod = PaymentMethodModel(name: name, paymentId: paymentId,
                                                               secureThumbnail: secureThumbnail,
                                                               paymentTypeId: paymentTypeId,
                                                               minAllowedAmount: minAllowedAmount,
                                                               maxAllowedAmount: maxAllowedAmount)
                        paymentMethodArray.append(paymentMethod)
                    }
                    DispatchQueue.main.async {
                        successCompletion(paymentMethodArray)
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

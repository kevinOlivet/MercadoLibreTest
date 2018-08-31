//
//  BankSelectRepo.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/29/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import Foundation

protocol BankSelectRepoProtocol {
    func getBankSelect(selectedPaymentMethodId: String,
                       successCompletion: @escaping ([BankSelectModel]?) -> Void,
                       failureCompletion: @escaping (String) -> Void)
    func downloadImage(urlString: String,
                       completion: @escaping (Data) -> Void)
}

extension Networker: BankSelectRepoProtocol {

    func getBankSelect(selectedPaymentMethodId: String,
                       successCompletion: @escaping ([BankSelectModel]?) -> Void,
                       failureCompletion: @escaping (String) -> Void) {

        let url = "https://api.mercadopago.com/v1/payment_methods/card_issuers?public_key=444a9ef5-8a6b-429f-abdf-587639155d88&payment_method_id=\(selectedPaymentMethodId)"

        var bankSelectModelArray: [BankSelectModel] = []

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
                        guard let bankId = dict["id"] as? String else { return }
                        guard let secureThumbnail = dict["secure_thumbnail"] as? String else { return }
                        let bankSelectModel = BankSelectModel(name: name,
                                                              bankId: bankId,
                                                              secureThumbnail: secureThumbnail)
                        bankSelectModelArray.append(bankSelectModel)
                    }
                    DispatchQueue.main.async {
                        successCompletion(bankSelectModelArray)
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

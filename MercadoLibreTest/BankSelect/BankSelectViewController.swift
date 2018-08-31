//
//  BankSelectViewController.swift
//  MercadoLibreTest
//
//  Created by Jon Olivet on 8/28/18.
//  Copyright © 2018 Jon Olivet. All rights reserved.
//

import UIKit

protocol BankSelectViewControllerProtocol: class {
    func setUpUI()
}

class BankSelectViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, BankSelectViewControllerProtocol {

    @IBOutlet weak var collectionView: UICollectionView!

    lazy var presenter: BankSelectPresenterProtocol = {
        let router = BankSelectRouter(view: self) as BankSelectRouterProtocol
        let repo = Networker() as BankSelectRepoProtocol
        return BankSelectPresenter(view: self,
                                   router: router,
                                   repo: repo)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    func setUpUI() {
        if let selectedPaymentMethod = presenter.selectedPaymentMethod {
            self.title = selectedPaymentMethod.name
        }
        let spinner = self.showModalSpinner()
        presenter.getBankSelect(successCompletion: { [weak self] (receivedBankSelectModels) in
            self?.hideModalSpinner(indicator: spinner)
            self?.collectionView.reloadData()
        }) { [weak self] (error) in
            self?.presenter.showErrorAlert(error: error)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.bankSelectModelArray.count > 0 ? presenter.bankSelectModelArray.count : 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankSelectCell", for: indexPath) as! BankSelectCollectionViewCell
        if presenter.bankSelectModelArray.count > 0 {
            let bankSelectModel = presenter.bankSelectModelArray[indexPath.row]
            cell.bankNameLabel.text = bankSelectModel.name
            presenter.downloadImage(urlString: bankSelectModel.secureThumbnail) { (data) in
                cell.bankSelectImageView.image = UIImage(data: data) ?? UIImage(named: "noImage")
            }
        } else {
            if let selectedPaymentMethod = presenter.selectedPaymentMethod {
                cell.bankNameLabel.text = selectedPaymentMethod.name
                presenter.downloadImage(urlString: selectedPaymentMethod.secureThumbnail) { (data) in
                    cell.bankSelectImageView.image = UIImage(data: data) ?? UIImage(named: "noImage")
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.handleDidSelectItem(indexPathItem: indexPath.row)
    }
}

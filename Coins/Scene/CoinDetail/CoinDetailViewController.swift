//
//  CoinDetailViewController.swift
//  Coins
//
//  Created by eyup cimen on 28.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CoinDetailDisplayLogic {
    func displayCoinDetail(viewModel: CoinDetail.SetUp.ViewModel)
}

class CoinDetailViewController: UIViewController, CoinDetailDisplayLogic {
    
    @IBOutlet weak var navbarSymbolLabel: UILabel!
    @IBOutlet weak var navbarNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var highValueLabel: UILabel!
    @IBOutlet weak var lowValueLabel: UILabel!
    
    var interactor: (CoinDetailInteracting & CoinDetailDataStore)!
    var router: (NSObjectProtocol & CoinDetailRoutingLogic & CoinDetailDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = CoinDetailInteractor()
        let presenter = CoinDetailPresenter()
        let router = CoinDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCoinDetail()
    }
    
    func getCoinDetail() {
        let request = CoinDetail.SetUp.Request()
        interactor?.coinDetail(request: request)
    }
    
    func displayCoinDetail(viewModel: CoinDetail.SetUp.ViewModel) {
        
        navbarSymbolLabel.text = viewModel.displayCoin.symbol
        navbarNameLabel.text = viewModel.displayCoin.name
        
        if let high = viewModel.displayCoin.sparkline.max() , let sparklineHigh = Decimal(string: high) {
            highValueLabel.text = NumberFormat.currencyFormatter(amount: sparklineHigh)
        }
        if let low = viewModel.displayCoin.sparkline.min() , let sparklineLow = Decimal(string: low) {
            lowValueLabel.text = NumberFormat.currencyFormatter(amount: sparklineLow)
        }
        if let priceDecimal = Decimal(string: viewModel.displayCoin.price) {
            priceLabel.text = NumberFormat.currencyFormatter(amount: priceDecimal)
        }
//        if let changeDouble = Double(viewModel.displayCoin.change), let priceDouble = Double(viewModel.displayCoin.price) {
//            let result = priceDouble * (changeDouble * 100)
//            changeLabel.text = String(format: "%.2f", result)
//        }
//        
        if let changeDouble = Double( viewModel.displayCoin.change), let priceDouble = Double(viewModel.displayCoin.price) {
            let result = priceDouble * (changeDouble * 100)
            changeLabel.textColor = result > 0 ? .systemGreen : .systemRed
            var resultString = ""
            resultString = String(format: "%.2f", result) + "%"
            if result > 0 {
                resultString.insert("+", at: resultString.startIndex )
            }
            changeLabel.text = resultString
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

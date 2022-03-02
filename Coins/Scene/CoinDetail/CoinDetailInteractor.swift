//
//  CoinDetailInteractor.swift
//  Coins
//
//  Created by eyup cimen on 28.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CoinDetailInteracting {
    func coinDetail(request: CoinDetail.SetUp.Request)
}

protocol CoinDetailDataStore {
    var displayCoin: CoinDetail.SetUp.ViewModel.DisplayCoin? {get set}
}

class CoinDetailInteractor: CoinDetailInteracting, CoinDetailDataStore {
    var presenter: CoinDetailPresentationLogic?
    var worker: CoinDetailWorker?
    var displayCoin: CoinDetail.SetUp.ViewModel.DisplayCoin?
    
    func coinDetail(request: CoinDetail.SetUp.Request) {
        guard let displayCoin = displayCoin else {
            return
        }
        let viewModel = CoinDetail.SetUp.ViewModel(displayCoin: displayCoin)
        presenter?.presentCoinDetail(viewModel: viewModel)
    }
}

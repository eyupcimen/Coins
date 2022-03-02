//
//  CoinDetailPresenter.swift
//  Coins
//
//  Created by eyup cimen on 28.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CoinDetailPresentationLogic {
    func presentCoinDetail(viewModel: CoinDetail.SetUp.ViewModel)
}

class CoinDetailPresenter {
    var viewController: CoinDetailViewController?
}

extension CoinDetailPresenter: CoinDetailPresentationLogic {
   
    func presentCoinDetail(viewModel: CoinDetail.SetUp.ViewModel) {
        viewController?.displayCoinDetail(viewModel: viewModel)
    }
}

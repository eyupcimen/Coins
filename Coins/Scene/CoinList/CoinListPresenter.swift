//
//  CoinListPresenter.swift
//  Coins
//
//  Created by eyup cimen on 24.02.2022.
//

import UIKit

protocol CoinListPresenting {
    func presentGetCoinList(response: CoinListModel.SetUp.Response)
}

class CoinListPresenter {
    var viewController: UIViewController?
}

extension CoinListPresenter: CoinListPresenting {
    
    // MARK: Presenting Coin List
    func presentGetCoinList(response: CoinListModel.SetUp.Response) {
        guard response.isSuccess else {
            if (viewController as AnyObject?) is CoinListViewController {
                (viewController as? CoinListViewController)?.displayCoinList(viewModel: nil)
            }
            return
        }
        var displayCoinList: [CoinListModel.SetUp.ViewModel.DisplayCoin] = []
        response.list.forEach({ item in
            let displayCoin = CoinListModel.SetUp.ViewModel.DisplayCoin.init(uuid: item.uuid ,
                                                                             symbol: item.symbol,
                                                                             name: item.name,
                                                                             color: item.color,
                                                                             iconUrl: item.iconUrl,
                                                                             marketCap: item.marketCap,
                                                                             price: item.price,
                                                                             listedAt: item.listedAt,
                                                                             tier: item.tier,
                                                                             change: item.change,
                                                                             rank: item.rank,
                                                                             sparkline: item.sparkline,
                                                                             lowVolume: item.lowVolume,
                                                                             coinrankingUrl: item.coinrankingUrl,
                                                                             the24HVolume: item.the24HVolume,
                                                                             btcPrice: item.btcPrice)
            displayCoinList.append(displayCoin)
        })
        let viewModel = CoinListModel.SetUp.ViewModel(displayCoins: displayCoinList)
        if (viewController as AnyObject?) is CoinListViewController { // For sperating display protocol for different view controller
            (viewController as? CoinListViewController)?.displayCoinList(viewModel: viewModel)
        }
    }
}

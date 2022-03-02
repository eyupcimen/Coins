//
//  CoinListRouter.swift
//  Coins
//
//  Created by eyup cimen on 24.02.2022.
//

import UIKit

protocol CoinListRoutingLogic {
    func changeSortType(headerView:HeaderView)
    func goToCoinDetailPage(seletedCoin: CoinListModel.SetUp.ViewModel.DisplayCoin)
}

protocol CoinListDataPassing {
    var dataStore: CoinListDataStore? {get}
}

class CoinListRouter: NSObject, CoinListRoutingLogic, CoinListDataPassing {
     
    weak var viewController: CoinListViewController?
    var dataStore: CoinListDataStore?
    
    func changeSortType(headerView:HeaderView) {
        guard let viewController = viewController else {
            return
        }
        let frame = headerView.convert(viewController.tableView.frame, to: viewController.view)
        let changeSortTypeVC = CoinStoryboard.coinList.viewController(with: ChangeSortTypeViewController.self)
        changeSortTypeVC.modalTransitionStyle = .crossDissolve
        changeSortTypeVC.modalPresentationStyle = .overCurrentContext
        changeSortTypeVC.topConstraint = frame.origin.y - viewController.topSafeArea + headerView.sortTypeView.frame.maxY
        changeSortTypeVC.widthhConstraint = headerView.sortTypeView.frame.width
        changeSortTypeVC.delegate = viewController
        viewController.present(changeSortTypeVC, animated: true, completion: nil)
    }
    
    func goToCoinDetailPage(seletedCoin: CoinListModel.SetUp.ViewModel.DisplayCoin) {
        guard let viewController = viewController else {
            return
        }
        let destinationVC = CoinStoryboard.coinList.viewController(with: CoinDetailViewController.self)
        var destinationDataStore = destinationVC.router!.dataStore!
        let displayCoin = CoinDetail.SetUp.ViewModel.DisplayCoin(uuid: seletedCoin.uuid,
                                                                 symbol: seletedCoin.symbol,
                                                                 name: seletedCoin.name,
                                                                 color: seletedCoin.color,
                                                                 iconUrl: seletedCoin.iconUrl,
                                                                 marketCap: seletedCoin.marketCap,
                                                                 price: seletedCoin.price,
                                                                 listedAt: seletedCoin.listedAt,
                                                                 tier: seletedCoin.tier,
                                                                 change: seletedCoin.change,
                                                                 rank: seletedCoin.rank,
                                                                 sparkline: seletedCoin.sparkline,
                                                                 lowVolume: seletedCoin.lowVolume,
                                                                 coinrankingUrl: seletedCoin.coinrankingUrl,
                                                                 the24HVolume: seletedCoin.the24HVolume,
                                                                 btcPrice: seletedCoin.btcPrice)
        destinationDataStore.displayCoin = displayCoin
        viewController.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

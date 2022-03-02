//
//  CoinDetailRouter.swift
//  Coins
//
//  Created by eyup cimen on 28.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol CoinDetailRoutingLogic {

}

protocol CoinDetailDataPassing {
    var dataStore: CoinDetailDataStore? { get }
}

class CoinDetailRouter: NSObject, CoinDetailRoutingLogic, CoinDetailDataPassing {
    weak var viewController: CoinDetailViewController?
    var dataStore: CoinDetailDataStore?    
}

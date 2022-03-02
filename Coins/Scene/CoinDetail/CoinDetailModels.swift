//
//  CoinDetailModels.swift
//  Coins
//
//  Created by eyup cimen on 28.02.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum CoinDetail {
    enum SetUp {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
            struct DisplayCoin {
                let uuid: String
                let symbol: String
                let name: String
                let color: String?
                let iconUrl: String
                let marketCap, price: String
                let listedAt, tier: Int
                let change: String
                let rank: Int
                let sparkline: [String]
                let lowVolume: Bool
                let coinrankingUrl: String
                let the24HVolume: String
                let btcPrice: String
            }
            var displayCoin: DisplayCoin
             
        }
    }
}

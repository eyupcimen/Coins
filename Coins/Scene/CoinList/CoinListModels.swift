//
//  CoinListModels.swift
//  Coins
//
//  Created by eyup cimen on 24.02.2022.
//

import UIKit

enum CoinListModel {
    enum SetUp {
        struct Request {
        }
        struct Response {
            var isSuccess:Bool
            var list: [Coin]
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
            var displayCoins: [DisplayCoin]
        }
    }
}

public struct CoinResponse: Codable {
    let status: String
    let data: DataClass
}

public struct DataClass: Codable {
    let stats: Stats
    let coins: [Coin]
}


public struct Coin: Codable {
    let uuid, symbol, name: String
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
    
    enum CodingKeys: String, CodingKey {
        case uuid, symbol, name, color
        case iconUrl, coinrankingUrl
        case marketCap, price, listedAt, tier, change, rank, sparkline, lowVolume
        case the24HVolume = "24hVolume"
        case btcPrice
    }
}

public struct Stats: Codable {
    let total, totalCoins, totalMarkets, totalExchanges: Int
    let totalMarketCap, total24HVolume: String
    
    enum CodingKeys: String, CodingKey {
        case total, totalCoins, totalMarkets, totalExchanges, totalMarketCap
        case total24HVolume = "total24hVolume"
    }
} 


enum SortType: String {
    case price = "Price"
    case marketCap = "Market Cap"
    case volume24 = "24h Vol"
    case change =  "Change"
}

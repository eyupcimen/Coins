//
//  CoinListWorker.swift
//  Coins
//
//  Created by eyup cimen on 24.02.2022.
//

import UIKit
import Moya

typealias coinListHandler = (Swift.Result<[Coin], APIError>) -> ()
 
                          
protocol CoinListDataProvidable {
    func getCoinList(completion: @escaping coinListHandler )
}

class CoinListWorker : CoinListDataProvidable {
    
    func getCoinList(completion: @escaping coinListHandler) {
        API.coinListProvider.request(.getCoinList) { result in
            switch result {
            case let .success(moyaResponse):
                if let coinResponse: CoinResponse  = moyaResponse.map() {
                    completion(.success(coinResponse.data.coins))
                } else {
                    completion(.failure(.wrongMapping))
                }
            case let .failure(moyaError):
                print("Error: \(moyaError)")
                completion(.failure(.serviceError))
            }
        }
    }
}

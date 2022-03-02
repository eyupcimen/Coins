//
//  MoyaProvider+CoinList.swift
//  Coins
//
//  Created by eyup cimen on 25.02.2022.
//
 
import Foundation
import Moya

public enum MoyaProviderCoinList {
    case getCoinList
    case getCoinDetail(id: String) // This is doesn't use.
    case getSvgImage(image:String)
}

extension MoyaProviderCoinList: TargetType {
    
    public var baseURL: URL {
        switch self {
        case .getCoinList, .getCoinDetail:
            let currentUrl = API.url.relativeString
            return URL(string: currentUrl)!
        case .getSvgImage:
            let currentUrl = API.imageUrl.relativeString
            return URL(string: currentUrl)!
        }
    }
    
    public var path: String {
        switch self {
        case .getCoinList, .getCoinDetail :
            return ""
        case .getSvgImage(let image):
            return "/\(image)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getCoinList, .getCoinDetail, .getSvgImage:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getCoinList, .getCoinDetail, .getSvgImage:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getCoinList, .getCoinDetail, .getSvgImage:
            return ["Content-type": "application/json","Accept": "application/json"]
        }
    } 
}

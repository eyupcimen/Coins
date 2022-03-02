//
//  API.swift
//  Coins
//
//  Created by eyup cimen on 24.02.2022.
//
import Foundation
import Moya
 
 
enum APIError: Error {
    case serviceError
    case userCancelled
    case wrongMapping
}

class API {
    static func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }

    static var url: URL {
        let baseUrl = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
        if let url = URL(string: baseUrl) {
            return url
        } else {
            fatalError("the api url not be empty")
        }
    }
    
    static var imageUrl: URL {
        let baseUrl = "https://cdn.coinranking.com/"
        if let url = URL(string: baseUrl) {
            return url
        } else {
            fatalError("the api url not be empty")
        }
    }
    
    static func plugins(logOptions: NetworkLoggerPlugin.Configuration.LogOptions = .verbose) -> Array<PluginType> {
        return [NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: API.JSONResponseDataFormatter), logOptions: logOptions))]
    }
    
    static var coinListProvider = MoyaProvider<MoyaProviderCoinList>(plugins: API.plugins()) // This is can be more options. for example userProfileProvider, loginProvide etc.
}


extension TargetType {
    public var headers: [String : String]? {
        // You can put on more header value if you want. For example
        // if let idToken = UserDefaults.standard.idToken {
        //     headers["Authorization"] = "Bearer \(idToken)"
        // }
        return headers
    }
    
    public var baseURL: URL {
        return API.url
    } 
}

extension Moya.Response {
    var url: String? {
        return self.request?.url?.absoluteString
    }
    
    func map<T: Decodable>() -> T? {
        do {
            let mapData = try JSONDecoder().decode(T.self, from: self.data)
            return mapData
        } catch {
            print(error)
            return nil
        }
        
    }
}

public enum NetworkActivityChangeType {
    case pre, began, ended
}

public final class NetworkActivityPlugin: PluginType {

    public typealias NetworkActivityClosure = (_ change: NetworkActivityChangeType, _ target: TargetType) -> Void
    let networkActivityClosure: NetworkActivityClosure
 
    public init(newNetworkActivityClosure: @escaping NetworkActivityClosure) {
        self.networkActivityClosure = newNetworkActivityClosure
    }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        networkActivityClosure(.pre, target)
        return request
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        networkActivityClosure(.began,target)
    }
 
    public func didReceive(_ result: Swift.Result<Moya.Response, MoyaError>, target: TargetType) {
        networkActivityClosure(.ended,target)
    }
}

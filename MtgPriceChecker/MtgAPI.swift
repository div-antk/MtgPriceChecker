//
//  MtgAPI.swift
//  MtgPriceChecker
//
//  Created by Takuya Ando on 2021/06/19.
//

import Foundation
import Moya

enum MtgAPI {
    case card(String)
}

extension MtgAPI: TargetType {
    
    var sampleData: Data {
        return Data()
    }
    
    var baseURL: URL {
        return URL(string: "https://api.scryfall.com")!
    }
    
    var path: String {
        return "/cards/search"
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var task: Task {
        switch self {
        case .card(let cardName):
            return .requestParameters(parameters: [
                "order" : "cmc",
                "q" : cardName
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}

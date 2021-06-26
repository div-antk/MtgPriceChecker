//
//  CardRepository.swift
//  MtgPriceChecker
//
//  Created by Takuya Ando on 2021/06/19.
//

import Foundation
import Moya
import RxSwift

final class CardRepository {
    private static let provider = MoyaProvider<MtgAPI>()
    private static let disposeBag = DisposeBag()
}

extension CardRepository {

    static func getCardData(name: String) -> Observable<[CardResponse]> {
        return provider.rx.request(.card(name))
            .map{ response in
                print("レス", response)
                let decoder = JSONDecoder()
                return try decoder.decode([CardResponse].self, from: response.data)
            }
            .asObservable()
    }
}

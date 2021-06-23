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
    private static let apiProvider = MoyaProvider<MtgAPI>()
    private static let disposeBag = DisposeBag()
}

extension CardRepository {

    static func getCardData(name: String) -> Observable<[CardResponse]> {
        return apiProvider.rx.request(.card(name))
            .map{ response in
                print("レス", )
                let decoder = JSONDecoder()
                return try decoder.decode([CardResponse].self, from: response.data)
            }
            .asObservable()
    }
}

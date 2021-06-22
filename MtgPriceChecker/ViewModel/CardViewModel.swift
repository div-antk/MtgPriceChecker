//
//  CardViewModel.swift
//  MtgPriceChecker
//
//  Created by Takuya Ando on 2021/06/20.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol CardViewModelInputs {
    var searchWord: AnyObserver<String> { get }
}

protocol CardViewModelOutputs {
    var cardData: Observable<[CardResponse]> { get }
}

protocol CardViewModelType {
    var input: CardViewModelInputs { get}
    var output: CardViewModelOutputs { get }
}

class CardViewModel: CardViewModelInputs, CardViewModelOutputs {

    // MARK: - INPUT
    let searchWord: AnyObserver<String>
    
    // MARK: - OUTPUT
    let cardData: Observable<[CardResponse]>
    
    // MARK: - OTHER
    private let disposeBag = DisposeBag()
    private let apiProvider = MoyaProvider<MtgAPI>()
    
    init() {
        // 流れてきたデータを cardDataに入れる
        let _cardData = PublishRelay<[CardResponse]>()
        self.cardData = _cardData.asObservable()
        
        
        let _searchWord = PublishRelay<String>()
        self.searchWord = AnyObserver<String>() { event in
            guard let text = event.element else { return }
            _searchWord.accept(text)
        }
        
        _searchWord
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .flatMap { searchWord in
                CardRepository.getCardData(name: searchWord)
            }
            .subscribe(onNext: { response in
                _cardData.accept(response)
            })
            .disposed(by: disposeBag)
        
    }
}

extension CardViewModel: CardViewModelType {
    var input: CardViewModelInputs { return self }
    var output: CardViewModelOutputs { return self }
}

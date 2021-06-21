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
    var input: CardViewModelInputs { get }
    var output: CardViewModelOutputs { get }
}

class CardViewModel: CardViewModelType, CardViewModelInputs, CardViewModelOutputs {
    
    var input: CardViewModelInputs
    var output: CardViewModelOutputs
    
    // MARK: - INPUT
    let searchWord: AnyObserver<String>
    
    // MARK: - OUTPUT
    let cardData: Observable<[CardResponse]>
    
    private let disposeBag = DisposeBag()
    private let apiProvider = MoyaProvider<MtgAPI>()
    
    init() {
        let _searchWord = PublishRelay<String>()
        self.searchWord = AnyObserver<String>() { event in
            guard let text = event.element else { return }
            _searchWord.accept(text)
        }
    }
}


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
    var cardDatas: Observable<[CardResponse]> { get }
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
    let cardDatas: Observable<[CardResponse]>
    
    private let disposeBag = DisposeBag()
    private let apiProvider = MoyaProvider<MtgAPI>()
    
    init() {
        
        
    }
}

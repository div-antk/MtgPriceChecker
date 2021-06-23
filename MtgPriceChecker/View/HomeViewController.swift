//
//  HomeViewController.swift
//  MtgPriceChecker
//
//  Created by Takuya Ando on 2021/06/16.
//

import UIKit
import RxSwift
import RxCocoa
import Instantiate
import InstantiateStandard

class HomeViewController: UIViewController, StoryboardInstantiatable {

    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var cardImageView: UIImageView!
    
    private var vm: CardViewModel!
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vm = CardViewModel()
        
        cardNameTextField.rx.text.orEmpty
            .filter{$0.count >= 1}
            .bind(to: vm.searchWord)
            .disposed(by: disposeBag)
        
    }


}


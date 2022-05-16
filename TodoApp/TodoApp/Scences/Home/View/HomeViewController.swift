//
//  HomeViewController.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 15/05/2022.
//

import UIKit
import RxSwift

final class HomeViewController: BaseViewController {
    private let goToContactList = PublishSubject<Void>()
    private let goToBuyList = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    
    @IBAction func handleCallListAction(_ sender: Any) {
        goToContactList.onNext(())
    }
    
    @IBAction func handleBuyListAction(_ sender: Any) {
        goToBuyList.onNext(())
    }
    
    @IBAction func handleSellListAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        bindingData()
    }

    private func bindingData() {
        
    }
}

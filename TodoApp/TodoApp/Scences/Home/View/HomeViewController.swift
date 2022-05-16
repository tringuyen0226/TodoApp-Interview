//
//  HomeViewController.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 15/05/2022.
//

import UIKit
import RxSwift

final class HomeViewController: RxBaseViewController<HomeViewModel> {
    private let goToContactList = PublishSubject<Void>()
    private let goToBuyList = PublishSubject<Void>()
    private let goToSellList = PublishSubject<Void>()
    
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
        bindingData()
    }
    
    private func bindingData() {
        let input = Input(goToCallListTrigger: goToContactList.asObservable(),
                          goToBuyListTrigger: goToBuyList.asObservable(),
                          goToSellListTrigger: goToSellList.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.goToCallListOutput.drive(onNext: { data in
            ScreenCoordinator.goToListContact(contacts: data)
        }).disposed(by: disposeBag)
        
        output.goToBuyListOutput.drive(onNext: { data in
            ScreenCoordinator.goToListDevice(devices: data)
        }).disposed(by: disposeBag)
        
        output.loadingIndicator.drive(rx.isLoading).disposed(by: disposeBag)
    }
}

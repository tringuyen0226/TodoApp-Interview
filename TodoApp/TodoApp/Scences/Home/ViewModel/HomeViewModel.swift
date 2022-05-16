//
//  HomeViewModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: ViewModelTrackable, ViewModelTransformable {
    var loadingIndicator = ActivityIndicator()
    var errorTracker = ErrorTracker()
    
    struct Input {
        let goToCallListTrigger: Observable<Void>
        let goToBuyListTrigger: Observable<Void>
        let goToSellListTrigger: Observable<Void>
    }
    
    struct Output {
        let goToCallListOutput: Driver<[ContactModel]>
        let goToBuyListOutput: Driver<[DeviceModel]>
        let goToSellListOutput: Observable<Void>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
    
    func transform(input: Input) -> Output {
        let goToCallListOutput = input.goToCallListTrigger
            .withUnretained(self)
            .flatMapLatest { vm,_ -> Observable<[ContactModel]> in
                return RxNetworking.rxGetContacts()
                    .track(vm)
            }.asDriverOnErrorJustComplete()
        
        let goToBuyListOutput = input.goToBuyListTrigger
            .withUnretained(self).flatMapLatest { vm,_ in
                return RxNetworking.rxGetDevices()
                    .track(vm)
            }.asDriverOnErrorJustComplete()
        
        return Output(goToCallListOutput: goToCallListOutput,
                      goToBuyListOutput: goToBuyListOutput,
                      goToSellListOutput: Observable.just(()),
                      loadingIndicator: loadingIndicator,
                      errorTracker: errorTracker)
    }
}

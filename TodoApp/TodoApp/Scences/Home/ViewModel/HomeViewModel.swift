//
//  HomeViewModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class HomeViewModel: NSObject, ViewModelTrackable, ViewModelTransformable {
    var loadingIndicator = ActivityIndicator()
    var errorTracker = ErrorTracker()
    private let disposeBag = DisposeBag()
    
    struct Input {
        let goToCallListTrigger: Observable<Void>
        let goToBuyListTrigger: Observable<Void>
        let goToSellListTrigger: Observable<Void>
    }
    
    struct Output {
        let goToCallListOutput: Driver<[ContactModel]>
        let goToBuyListOutput: Driver<[DeviceModel]>
        let goToSellListOutput: Driver<[DeviceModel]>
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
        
        let goToSellListOutput = input.goToSellListTrigger.withUnretained(self)
            .map { $0.0.getLocalDevice() }
            .asDriverOnErrorJustComplete()
        
        return Output(goToCallListOutput: goToCallListOutput,
                      goToBuyListOutput: goToBuyListOutput,
                      goToSellListOutput: goToSellListOutput,
                      loadingIndicator: loadingIndicator,
                      errorTracker: errorTracker)
    }
    
    private func getLocalDevice() -> [DeviceModel] {
        return ItemToSellModel.shared.getAll().map { DeviceModel(id: Int($0.id),
                                                                 name: $0.name.orEmpty,
                                                                 price: Int($0.price),
                                                                 quantity: Int($0.quantity),
                                                                 type: Int($0.type)) }
    }
}

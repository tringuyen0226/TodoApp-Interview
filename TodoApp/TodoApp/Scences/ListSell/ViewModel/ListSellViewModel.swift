//
//  ListSellViewModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class ListSellViewModel: ViewModelTrackable, ViewModelTransformable {
    var loadingIndicator = ActivityIndicator()
    var errorTracker = ErrorTracker()
    
    private let devices = BehaviorRelay<[DeviceModel]>(value: [])
    
    init(devices: [DeviceModel]) {
        self.devices.accept(devices)
    }
    
    struct Input {}
    
    struct Output{
        let listDeviceOutput: Driver<[DeviceModel]>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
    
    func transform(input: Input) -> Output {
        return Output(listDeviceOutput: devices.asDriverOnErrorJustComplete(),
                      loadingIndicator: loadingIndicator,
                      errorTracker: errorTracker)
    }
}

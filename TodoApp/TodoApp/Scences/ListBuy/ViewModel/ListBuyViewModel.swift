//
//  ListBuyViewModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ListDeviceViewModel: ViewModelTransformable, ViewModelTrackable {
    var loadingIndicator = ActivityIndicator()
    var errorTracker = ErrorTracker()
    
    struct Input {}
    
    struct Output {
        let listDeviceOutput: Driver<[DeviceModel]>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
    
    private let devices = BehaviorRelay<[DeviceModel]>(value: [])
    
    init(devices: [DeviceModel]) {
        self.devices.accept(devices)
    }
    
    
    func transform(input: Input) -> Output {
        return Output(listDeviceOutput: devices.asDriverOnErrorJustComplete(),
                      loadingIndicator: loadingIndicator,
                      errorTracker: errorTracker)
    }
}

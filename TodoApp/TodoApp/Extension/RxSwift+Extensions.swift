//
//  RxSwift+Extension.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

extension Driver {
    func flatMapOnBackground<R>(scheduler: SchedulerType, map: @escaping (Element) -> R) -> Driver<R> {
        return self.flatMapLatest { x in
            Observable.just(x)
                .observe(on: scheduler)
                .map(map)
                .asDriver(onErrorDriveWith: Driver<R>.never())
        }
    }
}

extension ObservableConvertibleType {
    func track( _ trackable: ViewModelTrackable) -> Observable<Element> {
        self.trackActivity(trackable.loadingIndicator)
            .trackError(trackable.errorTracker, action: .toast)
    }
}

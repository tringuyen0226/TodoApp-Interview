//
// Created by sergdort on 03/02/2017.
// Copyright (c) 2017 sergdort. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class ErrorTracker: SharedSequenceConvertibleType {
    public typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<(Error, ErrorAction)>()
    
    public init() {}
    
    public func trackError<O: ObservableConvertibleType>(from source: O, action: ErrorAction = .log) -> Observable<O.Element> {
        return source.asObservable().do(onError: {[weak self] err in
            self?.onError((err, action))
        })
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, (Error, ErrorAction)> {
        return _subject.asObservable().asDriverOnErrorJustComplete()
    }

    public func asObservable() -> Observable<(Error, ErrorAction)> {
        return _subject.asObservable()
    }

    private func onError(_ error: (Error, ErrorAction)) {
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}

public extension ObservableConvertibleType {
    func trackError(_ errorTracker: ErrorTracker, action: ErrorAction = .log) -> Observable<Element> {
        return errorTracker.trackError(from: self, action: action)
    }
}

public extension ObservableType {
    
    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

}


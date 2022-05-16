//
//  RxNetworking.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation
import RxSwift

class RxNetworking {
    private init() {}
    
    private static func resultHandler<T, E>(_ single: @escaping (SingleEvent<T>) -> Void) -> (Result<T, E>) -> Void  {
        { (result) in
            switch result {
            case .success(let response):
                single(.success(response))
            case .failure(let err):
                single(.failure(err))
            }
        }
    }
    
    static func rxGetContacts() -> Single<[ContactModel]> {
        return Single<[ContactModel]>.create { [unowned api = KzAPIClient.shared] single in
            api.getContacts(RxNetworking.resultHandler(single))
            return Disposables.create()
        }
    }
    
    static func rxGetDevices() -> Single<[DeviceModel]> {
        return Single<[DeviceModel]>.create { [unowned api = KzAPIClient.shared] single in
            api.getDevices(RxNetworking.resultHandler(single))
            return Disposables.create()
        }
    }
}


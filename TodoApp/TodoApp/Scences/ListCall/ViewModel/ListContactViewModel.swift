//
//  ListContactViewModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 17/05/2022.
//

import Foundation
import RxSwift
import RxCocoa

class ListContactViewModel: ViewModelTransformable, ViewModelTrackable {
    var loadingIndicator = ActivityIndicator()
    var errorTracker = ErrorTracker()
    
    struct Input {}
    
    struct Output {
        let listContactOutput: Driver<[ContactModel]>
        let loadingIndicator: ActivityIndicator
        let errorTracker: ErrorTracker
    }
    
    private let contacts = BehaviorRelay<[ContactModel]>(value: [])
    
    init(contacts: [ContactModel]) {
        self.contacts.accept(contacts)
    }
    
    
    func transform(input: Input) -> Output {
        return Output(listContactOutput: contacts.asDriverOnErrorJustComplete(),
                      loadingIndicator: loadingIndicator,
                      errorTracker: errorTracker)
    }
}

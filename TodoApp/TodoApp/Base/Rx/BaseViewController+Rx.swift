//
//  BaseViewController+Rx.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit
import RxSwift

extension Reactive where Base: BaseViewController {
    var isLoading: Binder<Bool> { Binder(base) { $1 ? $0.showLoadingIndicator() : $0.dismissLoadingIndicator()}}
    
    var error: Binder<(Error, ErrorAction)> {
        Binder(base) { (base: Base, payload: (err: Error, action: ErrorAction)) in
            base.handle(errorMessage: payload.err.localizedDescription, action: payload.action, completion: nil)
        }
    }
}

open class RxBaseViewController<T: ViewModelTransformable>: BaseViewController {
    public typealias Input = T.Input
    
    public let viewModel: T
    public let disposeBag = DisposeBag()
    
    public init(viewModel: T, nibName: String? = nil, bundle: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

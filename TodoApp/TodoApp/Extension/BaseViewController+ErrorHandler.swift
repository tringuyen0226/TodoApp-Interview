//
//  BaseViewController+ErrorHandler.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import UIKit

extension BaseViewController: ErrorHandler {}

protocol ErrorHandler {
    func handle(errorMessage: String, action: ErrorAction?, completion: CallBackClosure?)
}

extension ErrorHandler {
    func handle(errorMessage: String, action: ErrorAction? = .log, completion: CallBackClosure? = nil) {
        switch action {
        case .log:
            print("ERROR: \(errorMessage)")
            completion?()
        case .toast:
            Toast.showCenter(message: errorMessage, completion: completion)
        case .alert(let title):
            AlertHelpers.shareIntanse.showInformAlertWith(msg: title)
        case .none:
            completion?()
        }
    }
}

extension BaseViewController {
    func setTitle(title: String) {
        setTitle(title: title,
                 textColor: .black,
                 titleFont: UIFont.systemFont(ofSize: 16))
    }
}

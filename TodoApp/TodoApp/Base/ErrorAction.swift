//
//  ErrorAction.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public enum ErrorAction: Equatable {
    case alert(String)
    case toast
    case log
    
    public static func == (lhs: ErrorAction, rhs: ErrorAction) -> Bool {
        switch (lhs, rhs) {
        case (.log, .log),
            (.toast, .toast),
            (.alert, .alert):
            return true
        default:
            return false
        }
    }
}

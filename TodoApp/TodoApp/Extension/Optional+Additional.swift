//
//  Optional+Additional.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public extension Optional where Wrapped == String {
    var orEmpty: String {
        switch self {
        case .some(let value):
            return String(describing: value)
        default:
            return ""
        }
    }
    
    func emptyShouldReturn(defaultValue: String) -> String {
        switch self {
        case .some(let value):
            return value.isEmpty ? defaultValue : String(describing: value)
        default:
            return defaultValue
        }
    }
}

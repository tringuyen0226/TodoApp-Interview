//
//  ContactAPIs.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation
import Moya

enum ContactAPIs {
    case getContacts
}

extension ContactAPIs: BaseAPIs {
    var method: Moya.Method {
        switch self {
        case .getContacts:
            return Method.get
        }
    }
    
    var body: [String : Any] {
        switch self {
        case .getContacts:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getContacts:
            return "imkhan334/demo-1/call"
        }
    }
    
    var task: Task {
        switch self {
        case .getContacts:
            return .requestPlain
        }
    }
}

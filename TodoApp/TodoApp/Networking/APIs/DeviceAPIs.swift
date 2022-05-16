//
//  DeviceAPIs.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation
import Moya

enum DeviceAPIs {
    case getDevices
}

extension DeviceAPIs: BaseAPIs {
    var method: Moya.Method {
        switch self {
        case .getDevices:
            return Method.get
        }
    }
    
    var body: [String : Any] {
        switch self {
        case .getDevices: return [:]
        }
    }
    
    var path: String {
        switch self {
        case .getDevices:
            return "imkhan334/demo-1/buy"
        }
    }
    
    var task: Task {
        switch self {
        case .getDevices:
            return .requestPlain
        }
    }
}

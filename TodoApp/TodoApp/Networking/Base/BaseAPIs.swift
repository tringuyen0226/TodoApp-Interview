//
//  BaseAPIs.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation
import Moya

protocol BaseAPIs: TargetType {
    var body: [String: Any] { get }
}

extension BaseAPIs {
    var baseURL: URL {
        guard let url = KzAPIClient.shared.url else {
            fatalError("Invalid server URL")
        }
        return url
    }
    
    var sampleData: Data { Data() }
    
    var headers: [String : String]? {
        let headersConfig: [String: String] = [
            HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue,
            KZAPI.Token.rawValue: KzAPIClient.shared.token ?? "",
            KZAPI.Platform.rawValue: KzAPIClient.shared.platform ?? "",
            KZAPI.Domain.rawValue: KzAPIClient.shared.domain ?? "",
            KZAPI.Language.rawValue: KzAPIClient.shared.language ?? "",
            KZAPI.User.rawValue: KzAPIClient.shared.userToken ?? "",
            KZAPI.IP.rawValue: ""
        ]
        return headersConfig
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
}

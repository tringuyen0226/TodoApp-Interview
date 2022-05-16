//
//  KzAPIClient.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public class KzAPIClient: NetworkServices {

    public static let shared = KzAPIClient()
    
    var networking: NetworkServices = KzNetwork()
    
    var url: URL?
    var token: String?
    var platform: String?
    var domain: String?
    var language: String?
    var userToken: String?

    private init() {}
    
    public func config(with url: URL?, token: String?, platform: String?, domain: String, language: String?) {
        self.url = url
        self.token = token
        self.platform = platform
        self.domain = domain
        self.language = language
    }
    
    public func set(url: URL) {
        self.url = url
    }
    
    public func set(domain: String) {
        self.domain = domain
    }
    
    public func set(networking: NetworkServices) {
        self.networking = networking
    }
    
    public func set(language: String) {
        self.language = language
    }
    
    public func set(userToken: String) {
        self.userToken = userToken
    }
}

extension KzAPIClient {
    public func getContacts(_ completion: @escaping ((Result<[ContactModel], KzAPIsError>) -> Void)) {
        networking.getContacts(completion)
    }
    
    public func getDevices(_ completion: @escaping ((Result<[DeviceModel], KzAPIsError>) -> Void)) {
        networking.getDevices(completion)
    }
}

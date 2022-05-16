//
//  NetworkConfig.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum KZAPI: String {
    case Token = "X-KZAPI-TOKEN"
    case Platform = "X-KZAPI-PLATFORM"
    case Domain = "X-KZAPI-DOMAIN"
    case Language = "X-KZAPI-LANGUAGE"
    case User = "X-KZAPI-USER"
    case IP = "X-KZAPI-IP"
}

enum ContentType: String {
    case json = "application/json"
    case formUrlEncode = "application/x-www-form-urlencoded"
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPNetworkError: String, Error {
    case UnwrappingError = "Error Found : Unable to unwrape the data."
    case dataTaskFailed = "Error Found : The Data Task object failed."
    case success = "Successful Network Request"
    case authenticationError = "Error Found : You must be Authenticated"
    case badRequest = "Error Found : Bad Request"
    case pageNotFound = "Error Found : Page/Route rquested not found."
    case failed = "Error Found : Network Request failed"
    case serverSideError = "Error Found : Server error"
}

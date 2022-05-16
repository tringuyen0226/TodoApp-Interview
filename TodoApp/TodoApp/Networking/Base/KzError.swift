//
//  KzError.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public enum KzErrorCode: LocalizedError {
    case parseDataFailed
    case emptyData
    
    public var code: Int {
        switch self {
        case .parseDataFailed:
            return 3000
        case .emptyData:
            return 3001
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .parseDataFailed:
            return "Parse data failed!!!"
        case .emptyData:
            return "Success but no data!!!"
        }
    }
}

public struct KzAPIsError: LocalizedError {
    public var statusCode: Int
    public var msgError: String?
    public var data: KzAPIsErrorData?

    public init(statusCode: Int, msgError: String?, data: KzAPIsErrorData?) {
        self.statusCode = statusCode
        self.msgError = msgError
        self.data = data
    }
    
    public var errorDescription: String? {
        return msgError
    }
}

public struct KzAPIsErrorData: Codable {
    // Data return by BE is not standard code/msg OR c/m is depend
    public var code: Int?
    public var msg: String?
    
    public var c: Int?
    public var m: String?
    
    public init(code: Int, msg: String) {
        self.code = code
        self.msg = msg
        self.c = code
        self.m = msg
    }
}

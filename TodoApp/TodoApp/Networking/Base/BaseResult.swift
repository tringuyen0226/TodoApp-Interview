//
//  BaseResults.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

struct BaseResult<T: Codable>: Codable {
    let apiPath : String?
    let createdDate : Int?
    let data : T?
    let errorData : KzAPIsErrorData?
    let msg : String?
    let query : String?
    let status : Int?
    let updateDate : Int?
    
    enum CodingKeys: String, CodingKey {
        case apiPath = "apiPath"
        case createdDate = "createdDate"
        case data = "data"
        case errorData = "errorData"
        case msg = "msg"
        case query = "query"
        case status = "status"
        case updateDate = "updateDate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        apiPath = try? values.decodeIfPresent(String.self, forKey: .apiPath)
        createdDate = try? values.decodeIfPresent(Int.self, forKey: .createdDate)
        if let unwrapData = try? values.decodeIfPresent(T.self, forKey: .data) {
            data = unwrapData
            errorData = nil
        } else {
            data = nil
            errorData = try? values.decodeIfPresent(KzAPIsErrorData.self, forKey: .data)
        }
        msg = try? values.decodeIfPresent(String.self, forKey: .msg)
        query = try? values.decodeIfPresent(String.self, forKey: .query)
        status = try? values.decodeIfPresent(Int.self, forKey: .status)
        updateDate = try? values.decodeIfPresent(Int.self, forKey: .updateDate)
    }
    
}

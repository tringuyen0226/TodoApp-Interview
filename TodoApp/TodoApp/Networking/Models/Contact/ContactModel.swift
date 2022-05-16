//
//  ContactModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public struct ContactModel : Codable {
    let id : Int?
    let name : String?
    let number : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case number = "number"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        number = try values.decodeIfPresent(String.self, forKey: .number)
    }

}

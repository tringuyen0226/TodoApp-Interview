//
//  DeviceModel.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public struct DeviceModel : Codable {
    let id : Int?
    let name : String?
    let price : Int?
    let quantity : Int?
    let type : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case price = "price"
        case quantity = "quantity"
        case type = "type"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }

    init(id: Int, name: String, price: Int, quantity: Int, type: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
        self.type = type
    }
}


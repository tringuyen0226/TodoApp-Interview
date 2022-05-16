//
//  APIServices.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation

public protocol NetworkServices {
    func getContacts(_ completion: @escaping ((Result<[ContactModel], KzAPIsError>) -> Void))
    func getDevices(_ completion: @escaping ((Result<[DeviceModel], KzAPIsError>) -> Void))
}

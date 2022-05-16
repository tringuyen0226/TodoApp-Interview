//
//  KzNetwork.swift
//  TodoApp
//
//  Created by NguyenThanhTri on 16/05/2022.
//

import Foundation
import Moya

struct DataHandler {
    func handleResult<T: Codable>(_ result: Result<Moya.Response, MoyaError>) -> Result<T, KzAPIsError> {
        switch result {
        case .success(let response):
            return DataParser().handleApiResponse(data: response.data)
        case .failure(let error):
            return .failure(KzAPIsError(statusCode: error.errorCode, msgError: error.localizedDescription, data: nil))
        }
    }
}

struct DataParser {
    // MARK:  Base result to wrap all data in a template
    func handleResponse<T: Codable>(data: Data) -> Result<T, KzAPIsError> {
        do {
            let response = try JSONDecoder().decode(BaseResult<T>.self, from: data)
            if let statusCode = response.status {
                switch statusCode {
                case 0, 100:
                    if let responseData = response.data {
                        return .success(responseData)
                    } else {
                        return .failure(KzAPIsError(statusCode: KzErrorCode.emptyData.code, msgError: KzErrorCode.emptyData.errorDescription, data: nil))
                    }
                default:
                    do {
                        let response = try JSONDecoder().decode(BaseResult<KzAPIsErrorData>.self, from: data)
                        return .failure(KzAPIsError(statusCode: statusCode, msgError: response.msg, data: response.data))
                    } catch {
                        return .failure(KzAPIsError(statusCode: statusCode, msgError: response.msg, data: nil))
                    }
                }
            } else {
                return .failure(KzAPIsError(statusCode: KzErrorCode.parseDataFailed.code, msgError: KzErrorCode.parseDataFailed.errorDescription, data: nil))
            }
        } catch {
            return .failure(KzAPIsError(statusCode: KzErrorCode.parseDataFailed.code, msgError: KzErrorCode.parseDataFailed.errorDescription, data: nil))
        }
    }
    
    // MARK: Only handle this method for this "Todo app" cause the api response is simple. Should have better wrap data in a temple as above.
    func handleApiResponse<T: Codable>(data: Data) -> Result<T, KzAPIsError> {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return .success(response)
        } catch {
            return .failure(KzAPIsError(statusCode: KzErrorCode.parseDataFailed.code, msgError: KzErrorCode.parseDataFailed.errorDescription, data: nil))
        }
    }
}

public struct KzNetwork: NetworkServices {
    private let provider = MoyaProvider<MultiTarget>()
    
    public func getContacts(_ completion: @escaping ((Result<[ContactModel], KzAPIsError>) -> Void)) {
        provider.request(MultiTarget(ContactAPIs.getContacts), completion: { result in
            completion(DataHandler().handleResult(result))
        })
    }
    
    public func getDevices(_ completion: @escaping ((Result<[DeviceModel], KzAPIsError>) -> Void)) {
        provider.request(MultiTarget(DeviceAPIs.getDevices), completion: { result in
            completion(DataHandler().handleResult(result))
        })
    }
}

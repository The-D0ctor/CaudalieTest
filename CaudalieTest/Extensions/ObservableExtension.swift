//
//  ObservableExtension.swift
//  CaudalieTest
//
//  Created by Sébastien Rochelet on 31/05/2023.
//

import Foundation
import RxSwift

extension Observable where Element == (HTTPURLResponse, Data) {
    func expectingObject<T : Decodable>(ofType type: T.Type) ->                                                                  Observable<ApiResult<T, ApiErrorMessage>>
    {
        return self.map {
            (httpURLResponse: HTTPURLResponse, data: Data) -> ApiResult<T, ApiErrorMessage> in switch httpURLResponse.statusCode {
            case 200 ... 299:
                let object = try JSONDecoder().decode(type, from: data)
                return .success(object)
            default:
                return .failure(ApiErrorMessage(error_message: "Server Error."))
            }
        }
    }
}

enum ApiResult<Value, Error> {
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}

struct ApiErrorMessage: Codable {
    let error_message: String
}

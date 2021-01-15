//
//  ServiceClient.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import Foundation
import Alamofire

protocol ServiceClientProtocol {
    func request<T:Codable>(route: URLRequestConvertible, decodingType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void)
}

class ServiceClient: ServiceClientProtocol {
    func request<T:Codable>(route: URLRequestConvertible, decodingType: T.Type, completion: @escaping (_ response: T?, _ error: Error?) -> Void) {
        AF.request(route).validate().responseDecodable(of: T.self) { (response) in
            completion(response.value, response.error)
        }
    }
}

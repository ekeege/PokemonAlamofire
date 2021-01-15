//
//  PokemonRouter.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import Foundation
import Alamofire

enum PokemonRouter: URLRequestConvertible {
    
    static let baseURLPath = NetworkConstants.baseURL
    
    case pokemons
    case pokemon(name: String)
    
    var method: HTTPMethod {
        switch self {
        case .pokemons, .pokemon:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .pokemons:
            return "/pokemon"
        case .pokemon(name: let name):
            return "/pokemon/\(name)"
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .pokemons:
            return ["limit": 150]
        default:
            return [:]
        }
    }
    
    // MARK: - URLRequest
    public func asURLRequest() throws -> URLRequest {
        let url = try PokemonRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = 20
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
    
}

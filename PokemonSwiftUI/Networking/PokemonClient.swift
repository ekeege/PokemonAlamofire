//
//  PokemonClient.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import Foundation
import Alamofire

protocol PokemonClientProtocol {
    func getPokemons(completion: @escaping (_ response: [Pokemon]?, _ error: Error?) -> Void)
    func getPokemon(name: String, completion: @escaping (_ response: PokemonDetail?, _ error: Error?) -> Void)
}

class PokemonClient: PokemonClientProtocol {
    
    private let serviceClient: ServiceClientProtocol
    
    init(serviceClient: ServiceClientProtocol = ServiceClient()) {
        self.serviceClient = serviceClient
    }
    
    func getPokemons(completion: @escaping (_ response: [Pokemon]?, _ error: Error?) -> Void) {
        serviceClient.request(route: PokemonRouter.pokemons, decodingType: PokemonResponseModel.self) { (response, error) in
            
            guard error == nil,
                  let response = response,
                  let results = response.results else {
                completion(nil, error)
                return
            }
            
            completion(results, nil)
        }
    }
    
    func getPokemon(name: String, completion: @escaping (_ response: PokemonDetail?, _ error: Error?) -> Void) {
        serviceClient.request(route: PokemonRouter.pokemon(name: name), decodingType: PokemonDetail.self) { (response, error) in
            
            guard error == nil,
                  let response = response else {
                completion(nil, error)
                return
            }
            
            completion(response, nil)
        }
    }
}

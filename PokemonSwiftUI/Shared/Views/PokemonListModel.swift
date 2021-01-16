//
//  PokemonListModel.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 16.01.2021.
//

import Foundation

protocol PokemonListModelProtocol {
    func getPokemons(completion: @escaping (_ response: [PokemonDetail]?, _ error: Error?) -> Void)
}

class PokemonListModel: PokemonListModelProtocol {
    
    private var pokemonClient: PokemonClientProtocol = PokemonClient()
    
    func getPokemons(completion: @escaping (_ response: [PokemonDetail]?, _ error: Error?) -> Void) {
        var fetchedPokemons: [PokemonDetail] = []
        self.pokemonClient.getPokemons {(response, error) in
            guard error == nil,
                  let response = response else {
                completion(nil, error)
                print("Error getPokemons: \(error!)")
                return
            }
            
            for pokemon in response {
                self.pokemonClient.getPokemon(name: pokemon.name) { (response, error) in
                    guard error == nil else {
                        completion(nil, error)
                        print("Error getPokemon:  \(error!)")
                        return
                    }
                    
                    guard let response = response else {
                        print("getPokemon is empty")
                        completion(nil, error)
                        return
                    }
                        fetchedPokemons.append(response)
                }
            }
           completion(fetchedPokemons, nil)
        }
    }
}

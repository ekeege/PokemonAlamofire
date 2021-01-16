//
//  PokemonListModel.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 16.01.2021.
//

import Foundation

protocol PokemonListModelProtocol {
    var pokemons: [PokemonDetail] { get set }
    func getPokemons(completion: @escaping (_ response: [PokemonDetail]?, _ error: Error?) -> Void)
}

class PokemonListModel: PokemonListModelProtocol {
    
    private var pokemonClient: PokemonClientProtocol = PokemonClient()
    
    var pokemons: [PokemonDetail] = []
    
    func getPokemons(completion: @escaping (_ response: [PokemonDetail]?, _ error: Error?) -> Void) {
        var fetchedPokemons: [PokemonDetail] = []
        
        self.pokemonClient.getPokemons {(response, error) in
            guard error == nil,
                  let response = response else {
                completion(nil, error)
                print("Error getPokemons: \(error!)")
                return
            }
            
            let dispatchGroup = DispatchGroup()
            
            for pokemon in response {
                dispatchGroup.enter()
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
                    dispatchGroup.leave()
                }
            }
            
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                self.pokemons = fetchedPokemons
                completion(fetchedPokemons, nil)
            }
        }
    }
}

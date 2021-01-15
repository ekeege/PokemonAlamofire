//
//  PokemonListViewModel.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import Foundation
import Combine

protocol PokemonListViewModelProtocol {
    var pokemons: [PokemonDetail] { get set }
}

final class PokemonListViewModel: ObservableObject, PokemonListViewModelProtocol {
    
    @Published var pokemons: [PokemonDetail] = []
    
    //TODO: - Move this to another layer
    private var pokemonClient: PokemonClientProtocol = PokemonClient()
    
    init() {
        getPokemons()
    }
    
    func getPokemons()  {
        
        self.pokemonClient.getPokemons {(response, error) in
            guard error == nil,
                  let response = response else {
                print("Error getPokemons: \(error!)")
                return
            }
            
            for pokemon in response {
                self.pokemonClient.getPokemon(name: pokemon.name) { (response, error) in
                    guard error == nil else {
                        print("Error getPokemon:  \(error!)")
                        return
                    }
                    
                    guard let response = response else {
                        print("getPokemon is empty")
                        return
                    }
                    DispatchQueue.main.async {
                        self.pokemons.append(response)
                    }
                }
            }
        }
    }
}

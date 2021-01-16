//
//  PokemonListViewModel.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import Foundation
import Combine

enum PokemonType: String, CaseIterable {
    case fire
    case water
    case grass
    case none
}

protocol PokemonListViewModelProtocol {
    var pokemons: [PokemonDetail] { get set }
    var sortedPokemons: [PokemonDetail] { get }
    var filteredPokemons: [PokemonDetail] { get }
    var selectedFilter: PokemonType { get set }
}

final class PokemonListViewModel: ObservableObject, PokemonListViewModelProtocol {
    
    var selectedFilter: PokemonType = .none {
        didSet {
            switch selectedFilter {
            case .none:
                return
            default:
                DispatchQueue.main.async {
                    self.pokemons = self.pokemons.filter({ $0.types[0].type.name == self.selectedFilter.rawValue })
                }
            }
        }
    }
    
    @Published var pokemons: [PokemonDetail] = []
    @Published var searchText = ""
    
    init(model: PokemonListModelProtocol = PokemonListModel()) {
        self.model = model
        model.getPokemons { (response, error) in
            guard error == nil,
                  let response = response else {
                print("Error getPokemons: \(error!)")
                return
            }
            DispatchQueue.main.async {
                self.pokemons = response
            }
        }
    }
    
    var sortedPokemons: [PokemonDetail] {
        pokemons.sorted { $0.id < $1.id }
    }
    
    var filteredPokemons: [PokemonDetail] {
        sortedPokemons.filter({ searchText.isEmpty || $0.name.localizedStandardContains(searchText)})
    }
    
    let navigationTitle = TextConstants.pokemons
    let labelName =  TextConstants.filter
    let labelImage = ImageConstants.filterImageName
    
    //TODO: - Move this to another layer
    private var model: PokemonListModelProtocol
}

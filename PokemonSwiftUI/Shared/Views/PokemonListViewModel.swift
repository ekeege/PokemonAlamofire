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
    var filteredPokemons: [PokemonDetail] { get }
    var selectedFilter: PokemonType { get set }
}

final class PokemonListViewModel: ObservableObject, PokemonListViewModelProtocol {
    
    @Published var pokemons: [PokemonDetail] = []
    @Published var searchText: String = ""
    
    private var model: PokemonListModelProtocol
    
    init(model: PokemonListModelProtocol = PokemonListModel()) {
        self.model = model
        model.getPokemons { (response, error) in
            guard error == nil,
                  let response = response else {
                print("Error getPokemons: \(error!)")
                return
            }
            self.pokemons = response
        }
    }
    
    var selectedFilter: PokemonType = .none {
        didSet {
            switch selectedFilter {
            case .none:
                self.pokemons = self.model.pokemons
            default:
                self.pokemons = self.model.pokemons.filter({ $0.types[0].type.name == self.selectedFilter.rawValue })
            }
        }
    }
    
    var filteredPokemons: [PokemonDetail] {
        model.pokemons
            .filter({ searchText.isEmpty || $0.name.localizedStandardContains(searchText)})
            .filter({ $0.types[0].type.name == self.selectedFilter.rawValue || selectedFilter == .none })
            .sorted { $0.id < $1.id }
    }
    
    let navigationTitle = TextConstants.pokemons
    let labelName =  TextConstants.filter
    let labelImage = ImageConstants.filterImageName
}

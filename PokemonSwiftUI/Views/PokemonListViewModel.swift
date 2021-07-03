//
//  PokemonListViewModel.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import SwiftUI
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
    func removePokemon(with id: Int)
    func getPokemons()
}

final class PokemonListViewModel: ObservableObject, PokemonListViewModelProtocol {

    @Published var pokemons: [PokemonDetail] = []
    @Published var searchText: String = ""
    @Published var suggestions: [String] = []
    
    private var model: PokemonListModelProtocol

    init(model: PokemonListModelProtocol = PokemonListModel()) {
        self.model = model
        getPokemons()
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
        pokemons
            .filter({ searchText.isEmpty || $0.name.localizedStandardContains(searchText)})
            .filter({ $0.types[0].type.name == self.selectedFilter.rawValue || selectedFilter == .none })
            .sorted { $0.id < $1.id }
    }

    func removePokemon(with id: Int) {
        model.pokemons.removeAll(where: { $0.id == id })
        withAnimation {
            pokemons.removeAll(where: { $0.id == id })
        }
    }

    func getPokemons() {
        pokemons.removeAll()
        model.getPokemons { [weak self] (response, error) in
            guard let self = self,
                  error == nil,
                  let response = response else {
                print("Error getPokemons: \(error!)")
                return
            }
            self.pokemons = response
            self.suggestions = Array(self.pokemons.prefix(Int.random(in: 0..<10))).map { $0.name }
        }
    }

    func listSeperatorTintColor(for pokemon: PokemonDetail) -> Color {
        let type: PokemonType = PokemonType(rawValue: pokemon.types[0].type.name) ?? .none
        switch type {
        case .fire:
            return .orange
        case .water:
            return .blue
        case .grass:
            return .green
        case .none:
            return .gray
        }
    }
    
    let navigationTitle = TextConstants.pokemons
    let labelName =  TextConstants.filter
    let labelImage = ImageConstants.filterImageName
}

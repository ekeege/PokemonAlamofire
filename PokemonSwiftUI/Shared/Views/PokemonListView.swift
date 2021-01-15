//
//  PokemonListView.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var pokemonListVM = PokemonListViewModel()
    
    @ViewBuilder
    var progressView: some View {
        if pokemonListVM.pokemons.isEmpty {
            ProgressView()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(pokemonListVM.pokemons, id: \.name) { pokemon in
                    PokemonListRowView(pokemon: pokemon)
                }
            }
            .overlay(progressView)
            .navigationTitle("Pokemons")
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonListView()
            PokemonListView()
                .colorScheme(.dark)
        }
    }
}

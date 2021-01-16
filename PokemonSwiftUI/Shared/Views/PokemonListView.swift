//
//  PokemonListView.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var pokemonListVM = PokemonListViewModel()
    @StateObject var searchBar = UIKitSearchBar()
    
    @ViewBuilder
    var progressView: some View {
        if pokemonListVM.pokemons.isEmpty {
            ProgressView()
        }
    }
    
    var body: some View {
        List {
            ForEach(pokemonListVM.filteredPokemons) { pokemon in
                NavigationLink(destination: PokemonListDetailView(pokemon: pokemon)) {
                    PokemonListRowView(pokemon: pokemon)
                }
            }
        }
        .onChange(of: searchBar.text, perform: { value in
            pokemonListVM.searchText = searchBar.text
        })
        .overlay(progressView)
        .add(searchBar)
        .navigationTitle(pokemonListVM.navigationTitle)
        .toolbar  {
            ToolbarItem(placement: .navigationBarTrailing) {
                
                Menu {
                    Picker("", selection: $pokemonListVM.selectedFilter) {
                        ForEach(PokemonType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                } label: {
                    Label(pokemonListVM.labelName, systemImage: pokemonListVM.labelImage)
                        .font(.title2)
                }
            }
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

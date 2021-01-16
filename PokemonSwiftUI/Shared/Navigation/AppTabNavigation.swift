//
//  AppTabNavigation.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 16.01.2021.
//

import SwiftUI

struct AppTabNavigation: View {
    
    @State private var selection: Tab = .pokemons
    
    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                PokemonListView()
            }
            .tabItem {
                Label(TextConstants.pokemons, systemImage: ImageConstants.houseImageName)
            }
            .tag(Tab.pokemons)
            NavigationView {
                Text("Favorites")
            }
            .tabItem {
                Label(TextConstants.favorites, systemImage: ImageConstants.favoriteImageName)
            }
            .tag(Tab.favorites)
        }
        
    }
}

// MARK: - Tab

extension AppTabNavigation {
    enum Tab {
        case pokemons
        case favorites
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}

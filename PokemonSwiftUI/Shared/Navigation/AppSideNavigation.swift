//
//  AppSideNavigation.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 16.01.2021.
//

import SwiftUI

struct AppSideNavigation: View {
    
    var sidebar: some View {
        List {
            NavigationLink(destination: PokemonListView()) {
                Label(TextConstants.pokemons, systemImage: ImageConstants.houseImageName)
            }
            .tag(NavigationItem.pokemons)
            
            NavigationLink(destination: Text("Favorites")) {
                Label(TextConstants.favorites, systemImage: ImageConstants.favoriteImageName)
            }
            .tag(NavigationItem.favorites)
        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            sidebar
            
            Text("Please choose a category")
                .foregroundColor(.secondary)
            
            Text("Please choose a pokemon")
                .foregroundColor(.secondary)
        }
        
    }
}

// MARK: - NavigationItem

extension AppSideNavigation {
    enum NavigationItem {
        case pokemons
        case favorites
    }
}

struct AppSideNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSideNavigation()
    }
}

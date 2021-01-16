//
//  PokemonListDetailView.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 16.01.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonListDetailView: View {
    
    let pokemon: PokemonDetail
    
    var frontImageURL: URL {
        guard let url = URL(string: pokemon.sprites.frontDefault) else {
            return URL(string: "Not implemented yet")!
        }
        return url
    }
    
    
    var backImageURL: URL {
        guard let url = URL(string: pokemon.sprites.backDefault) else {
            return URL(string: "Not implemented yet")!
        }
        return url
    }
    
    var body: some View {
        List {
            Section(header: Text("Sprites")) {
                HStack {
                    Spacer()
                    WebImage(url: frontImageURL)
                        .indicator(.activity)
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    
                    WebImage(url: backImageURL)
                        .indicator(.activity)
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                    Spacer()
                    
                }
                
            }
            Section(header: Text("Info")) {
                infoRow(info: "Height", detail: "\(pokemon.height)")
                infoRow(info: "Weight", detail: "\(pokemon.weight)")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(pokemon.name)
    }
    
    func infoRow(info: String, detail: String) -> some View {
        HStack {
            Text(info)
            Spacer()
            Text(detail)
                .fontWeight(.semibold)
        }
    }
}

struct PokemonListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListDetailView(pokemon: .testData)
    }
}

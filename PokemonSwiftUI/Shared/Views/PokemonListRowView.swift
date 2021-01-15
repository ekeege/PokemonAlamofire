//
//  PokemonListRowView.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 14.01.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonListRowView: View {
    
    var metrics: Metrics {
        return Metrics(textPadding: 8,
                       thumbnailSize: 76,
                       rowPadding: 0,
                       cornerRadius: 16
        )
    }
    
    let pokemon: PokemonDetail
    
    var imageURL: URL {
        guard let url = URL(string: pokemon.sprites.frontDefault) else {
            return URL(string: "Not implemented yet")!
        }
        return url
    }
    
    var body: some View {
        HStack {
            WebImage(url: imageURL)
                .indicator(.activity)
                .scaledToFit()
                .frame(width: metrics.thumbnailSize, height: metrics.thumbnailSize)
            
            VStack(alignment: .leading) {
                Text("#\(pokemon.id)")
                    .font(.headline)
                
                Text(pokemon.name)
                HStack {
                    Text("Types:")
                    ForEach(0..<pokemon.types.count, id: \.self) { i in
                        Text(pokemon.types[i].type.name)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .lineLimit(1)
            .padding(.vertical, metrics.textPadding)
            
            Spacer()
        }
        .font(.subheadline)
        .padding(.vertical, metrics.rowPadding)
    }
    
    struct Metrics {
        var textPadding: CGFloat
        var thumbnailSize: CGFloat
        var rowPadding: CGFloat
        var cornerRadius: CGFloat
    }
}

struct PokemonListRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonListRowView(pokemon: .testData)
            PokemonListRowView(pokemon: .testData)
                .background(Color(.systemBackground))
                .colorScheme(.dark)
        }
        .frame(width: 250, alignment: .leading)
        .previewLayout(.sizeThatFits)
    }
}

//
//  PokemonModel.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 15.01.2021.
//

import Foundation

struct Pokemon: Codable {
    var name: String
}

struct PokemonDetail: Codable, Identifiable {
    var id: Int
    var name: String
    let weight: Int
    let height: Int
    var sprites: Sprite
    let types: [TypeElement]
}

struct TypeElement: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}

struct Sprite: Codable {
    let frontDefault: String
    let backDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
    }
}

struct DreamWorld: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

//MARK: - Mock
extension PokemonDetail {
    static let testData = PokemonDetail(id: 0,
                                        name: "Unknown",
                                        weight: 0,
                                        height: 0,
                                        sprites: Sprite(frontDefault: "Unknown",
                                                       backDefault: "Unknown"),
                                        types: [TypeElement(type: Type(name: "Unknown"))])
}

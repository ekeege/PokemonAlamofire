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
    let other: SpriteOther
    
    enum CodingKeys: String, CodingKey {
        case other
        case frontDefault = "front_default"
    }
}

struct SpriteOther: Codable {
    let dreamWorld: DreamWorld
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
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
    static let testData = PokemonDetail(id: 0, name: "Unknown",
                                        sprites: Sprite(frontDefault: "Unknown",
                                                       other: SpriteOther(dreamWorld: DreamWorld(frontDefault: "Unknown"))),
                                        types: [TypeElement(type: Type(name: "Unknown"))])
}

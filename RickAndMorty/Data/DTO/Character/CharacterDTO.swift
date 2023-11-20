//
//  CharacterDTO.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import Foundation

struct CharacterDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, type
        case gender, origin, location, image
        case episodes = "episode"
        case url, created
    }

    var id: Int
    var name: String?
    var status: StatusDTO?
    var species: String?
    var type: String?
    var gender: String?
    var origin: LocationDTO?
    var location: LocationDTO?
    var image: String?
    var episodes: [String]?
    var url: String?
    var created: String?

    init(entity: Character) {
        self.id = entity.id
        self.name = entity.name
        self.status = StatusDTO(entity: entity.status)
        self.species = entity.species
        self.type = entity.type
        self.gender = entity.gender.rawValue
        self.image = entity.image
    }

    init(id: Int, name: String? = nil, status: StatusDTO? = nil, species: String? = nil, type: String? = nil, gender: String? = nil, origin: LocationDTO? = nil, location: LocationDTO? = nil, image: String? = nil, episodes: [String]? = nil, url: String? = nil, created: String? = nil) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episodes = episodes
        self.url = url
        self.created = created
    }
}

struct LocationDTO: Codable {
    var name: String?
    var url: String?
}

enum StatusDTO: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

    init(entity: Status) {
        switch entity {
        case .alive:
            self = .alive
        case .dead:
            self = .dead
        case .unknown:
            self = .unknown
        }
    }
}

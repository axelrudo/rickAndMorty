//
//  Character.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import UIKit

struct Character {
    var id: Int
    var name: String
    var status: Status
    var species: String
    var type: String
    var gender: Gender
    var image: String

    var isFavorite: Bool = false

    init(dto: CharacterDTO) {
        self.id = dto.id
        self.name = dto.name ?? ""
        self.status = Status(dto: dto.status ?? .unknown)
        self.species = dto.species ?? ""
        self.type = dto.type ?? ""
        self.gender = Gender(rawValue: dto.gender ?? "unknown") ?? .unknown
        self.image = dto.image ?? ""
    }
}

enum Gender: String {
    case female = "Female"
    case male = "Male"
    case genderLess = "Genderless"
    case unknown = "unknown"
}

enum Status {
    case alive
    case dead
    case unknown

    init(dto: StatusDTO) {
        switch dto {
        case .alive:
            self = .alive
        case .dead:
            self = .dead
        case .unknown:
            self = .unknown
        }
    }

    var color: UIColor {
        switch self {
        case .alive:
            return .green
        case .dead:
            return .red
        case .unknown:
            return .lightGray
        }
    }
}

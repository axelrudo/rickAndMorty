//
//  PaginationDTO.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import Foundation

struct PaginationDTO<T: Codable>: Codable {
    var info: InfoDTO?
    var results: [T]?
}

struct InfoDTO: Codable {
    var count: Int?
    var pages: Int?
    var next: String?
    var prev: String?
}

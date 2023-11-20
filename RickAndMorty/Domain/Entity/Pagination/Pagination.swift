//
//  Pagination.swift
//  RickAndMorty
//
//  Created by axel on 26/7/23.
//

import Foundation

struct Pagination<T> {
    var results: [T] = []
    var hasNextPage: Bool = true
}

//
//  SimilarMovies.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import Foundation

struct SimilarMovies: Codable {
    let results: [Results]?
}

struct Results: Codable {
    let posterPath: String?
    let releaseDate: String?
    let genreIds: [Int]?
    let title: String?
}

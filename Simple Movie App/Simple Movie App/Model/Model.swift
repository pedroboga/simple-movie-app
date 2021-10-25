//
//  Model.swift
//  Simple Movie App
//
//  Created by Pedro Boga on 25/10/21.
//

import Foundation

struct Movie: Decodable {
    let popularity: Float?
    let posterPath: String?
    let title: String?
    let voteCount: Int?
}

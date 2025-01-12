//
//  Result.swift
//  CupcakeCorner
//
//  Created by Gary on 24/12/2024.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

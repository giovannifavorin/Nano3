//
//  APIModel.swift
//  Nano3
//
//  Created by Gabriel Eirado on 29/08/23.
//

import Foundation

struct APIResponse: Hashable, Codable {
    let q: String
    let a: String
}

struct Quotes {
    var isFavorited: Bool
    let APIResponse: APIResponse
}

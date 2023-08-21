//
//  ApiRequest.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import CoreData
import SwiftUI

struct APIResponse: Hashable, Codable {
    let q: String
    let a: String
}

struct Quotes {
    var isFavorited: Bool
    let APIResponse: APIResponse
}

class APIViewModel: ObservableObject {
    @Published var quotes: [APIResponse] = [] // Use an array of Quote objects
    let apiObject = APIModel()

    func fetch() {
            Task{
                do {
                    let fetchedUser: [APIResponse] = try await apiObject.get(APIurl: "https://zenquotes.io/api/random")
                    DispatchQueue.main.async {
                        self.quotes = fetchedUser
                    }
                    print("API was called")
                }
                 catch{
                    print("error")
                }
            }
        }
}

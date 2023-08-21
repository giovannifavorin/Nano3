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
    
    func fetch() {
        guard let url = URL(string: "https://zenquotes.io/api/random") else {
            print ("ERRO chamando a API")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let response = try JSONDecoder().decode([APIResponse].self, from: data) // Decode an array of Quote
                DispatchQueue.main.async {
                    self?.quotes = response
                }
            } catch {
                print("Erro abrindo a API \(error)")
            }
        }
        task.resume()
    }
}

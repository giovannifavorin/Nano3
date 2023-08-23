//
//  APIModel.swift
//  Nano3
//
//  Created by Gabriel Eirado on 21/08/23.
//

import Foundation
import SwiftUI

class APIModel {
    func get<T: Decodable>(APIurl: String) async throws -> T {
        guard let url = URL(string: APIurl) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse("Invalid response: \(response)")
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedObject = try decoder.decode(T.self, from: data)
                return decodedObject
            } catch {
                throw APIError.invalidData("Invalid data: \(error)")
            }
        } catch {
            throw APIError.invalidData("Failed to fetch data: \(error)")
        }
    }
    
    func post<T: Decodable, U: Encodable>(APIurl: String, requestBody: U) async throws -> T {
        guard let url = URL(string: APIurl) else {
            throw APIError.invalidURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(requestBody)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw APIError.invalidResponse("Invalid response: \(response)")
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let decodedObject = try decoder.decode(T.self, from: data)
                return decodedObject
            } catch {
                throw APIError.invalidData("Invalid data: \(error)")
            }
        } catch {
            throw APIError.invalidData("Failed to fetch data: \(error)")
        }
    }
}


//
//  APIModel.swift
//  Nano3
//
//  Created by Gabriel Eirado on 21/08/23.
//

import Foundation
import SwiftUI


class APIUtility{
    
    func get<T: Decodable>(APIurl: String) async throws -> T {
        
        guard let url = URL(string: APIurl) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...201).contains(httpResponse.statusCode)else {
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
    
    

    func post<U: Encodable>(APIurl: String, body: U) async throws {

        
        guard let url = URL(string: APIurl) else {
            throw APIError.invalidURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            
            guard let httpResponse = response as? HTTPURLResponse, (200...201).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse("Invalid response: \(response)")
            }
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            if let dataResponse = String(data: data, encoding: .utf8) {
                print("Response Data:\n\(dataResponse)")
            }
            
        } catch {
            throw APIError.invalidData("Failed to fetch data: \(error)")
        }
    }
    
    
    
    
    func put<U: Encodable>(APIurl: String, body: U) async throws { // need more logic
        
        guard let url = URL(string: APIurl) else {
            throw APIError.invalidURL
        }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...204).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse("Invalid response: \(response)")
            }
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            if let dataResponse = String(data: data, encoding: .utf8) {
                print("Response Data:\n\(dataResponse)")
            }
            
        } catch {
            throw APIError.invalidData("Failed to update data: \(error)")
        }
    }
    
    func delete(APIurl: String) async throws { // need more logic
        
        guard let url = URL(string: APIurl) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...204).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse("Invalid response: \(response)")
            }
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
        } catch {
            throw APIError.invalidData("Failed to delete data: \(error)")
        }
    }
}



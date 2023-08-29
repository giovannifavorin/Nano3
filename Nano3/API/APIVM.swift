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
    
    struct PostData: Encodable {
        let name: String
        let age: String
    }

    let APIurl = "https://dummy.restapiexample.com/api/v1/create"
    let APIurl2 = "https://reqres.in/api/users"
    let postData = PostData(name: "cleber", age: "i'm 21 years old")

    func postRequest(){
        Task{
            do {
                try await apiObject.post(APIurl: APIurl2, body: postData)
                print("post done")
            } catch{
                print("cant post")
            }
        }
    }
    
    func deleteRequest(){
        Task{
            do {
                try await apiObject.delete(APIurl: "https://reqres.in/api/users/2")
                print("Delete successful")
            } catch {
                print("Error deleting data")
            }
        }
    }
}



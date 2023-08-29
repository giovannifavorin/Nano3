//
//  ApiRequest.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import CoreData
import SwiftUI

class APIViewModel: ObservableObject {
    @Published var quotes: [APIResponse] = [] // Use an array of Quote objects
    let APIurl = "https://dummy.restapiexample.com/api/v1/create"
    let APIurl2 = "https://reqres.in/api/users"
    
    let apiObject = APIUtility()

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
 
    func postRequest(phrase: String){
        Task{
            do {
                print("aaaaa\(phrase)")
                try await apiObject.post(APIurl: APIurl, body: "\(phrase)")
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



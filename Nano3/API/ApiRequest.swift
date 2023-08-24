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


struct Employee:Codable{
    let name:String
    let salary:Float
    let age: Int
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
    
    struct PasteBin:Codable{
        var api_dev_key:String = "wH-znJIi-LkLNm37w6oH-o60C3KOVSEk"
        var api_option:String = "paste"
        let api_paste_code:String
    }
    
    var body = PasteBin(api_paste_code: "asfasfasfas")
    var url = "https://pastebin.com/api/api_post.php"
    let APIurl = "https://dummy.restapiexample.com/api/v1/create"
    let APIurl2 = "https://reqres.in/api/users"

    func post(){
        Task{
            do{
              try await apiObject.post(APIurl: APIurl2, body: Employee(name: "teste", salary: 1250, age: 33))
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

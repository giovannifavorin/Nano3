//
//  ContentVM.swift
//  Nano3
//
//  Created by Gabriel Eirado on 21/08/23.
//

import Foundation

struct QuoteResponse: Codable {
//    let q: String
    let a: String?
//    let i: String?
//    let c: String?
//    let h: String?
}

//struct QuoteResponse: Codable{
//    let array: [Quote]
//}


class ContentVM: ObservableObject{
    
    var manager = APIModel()
    @Published var quote: QuoteResponse?
    
    func fetch() {
        Task{
            do {
                let fetchedUser: [QuoteResponse] = try await manager.get(APIurl: "https://zenquotes.io/api/random")
                DispatchQueue.main.async {
                    self.quote = fetchedUser.first
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

    func post() {
        Task{
            do {
                try await manager.post(APIurl: APIurl2, body: postData)
                print("post done")
            } catch{
                print("cant post")
            }
        }
    }
    
}

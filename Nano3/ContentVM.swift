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
}

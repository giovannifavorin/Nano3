//
//  ContentVM.swift
//  Nano3
//
//  Created by Gabriel Eirado on 21/08/23.
//

import Foundation

struct QuoteResponse: Codable {
    let q: String?
//    let a: String?
//    let i: String?
//    let c: String?
//    let h: String?
}

struct GitHubUser: Codable {
    let login: String?
//    let avatarUrl: String?
//    let bio: String?
}

class ContentVM: ObservableObject{
    
    var manager = APIModel()
    @Published var quote: GitHubUser?
    
    func fetch() {
        Task{
            do {
                let fetchedUser: GitHubUser = try await manager.get(APIurl: "https://api.github.com/users/a")
                DispatchQueue.main.async {
                    self.quote = fetchedUser
                }
                print("API was called")
            }
             catch{
                print("error")
            }
        }
    }
}

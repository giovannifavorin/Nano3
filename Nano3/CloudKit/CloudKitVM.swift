//
//  CloudKitModel.swift
//  Nano3
//
//  Created by Gabriel Eirado on 24/08/23.
//

import Foundation
import CloudKit


class CloudKitVM: ObservableObject{
    
    @Published var status: String = ""
    @Published var fetchedItems: [String] = []

    
    init(){
        fetchPermission()
        fetchStatus()
//        fetchID()
        fetchUserName()
        fetchItems()
    }
    
    @Published var text:String = ""
    var manager = CloudKitUtility()
    
    
    func fetchStatus(){
        Task{
            do{
             let response = try await manager.getIcloudStatus()
                DispatchQueue.main.async {
                    self.status = response.rawValue.description
                }
            }catch{
                print(error)
            }
        }
    }
    func fetchPermission(){
        Task{
            do{
                let response = try await manager.getPermission()
                print(response)
            }catch{
                print(error)
                print("deu ruinm")
            }
        }
    }
    
    func fetchID(){
        Task{
            do{
                let response = try await manager.getUserID()
                print(response)

            }catch{
                print(error)
            }
        }
    }
    
    func fetchUserName(){
        Task{
            do{
                let id = try await manager.getUserID()
                guard (try await manager.getIcloudName(id: id)?.nameComponents?.givenName) != nil else{
                    throw CloudKitError.nameNotFound
                }
            }catch{
                print(error)
            }
        }
    }
    
    // CRUD
    
    func saveItems(phrase: String){
        Task{
            do{
                try await manager.addItem(phrase: phrase, recordType: "phrases")
            }catch{
                print(error)
            }
        }
    }
    
    func fetchItems() {
        Task {
            do {
                DispatchQueue.main.async {
                    self.fetchedItems = []
                }
                let response = try await manager.fetchItems(recordType: "phrases")
    
                try response.forEach { (_, result) in
                    switch result {
                    case .success(let record):
                        if let items = record.value(forKey: "phrases") as? String {
                            DispatchQueue.main.async {
                                self.fetchedItems.append(items)
                            }
                        }
                    case .failure(let error):
                        throw error
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}

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
//    var id: CKRecord.ID
    
    
    init(){
        fetchPermission()
        fetchStatus()
//        fetchID()
        fetchUserName()
        fetchItems()
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
                print("deu merda")
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
                guard let response = try await manager.getIcloudName(id: id)?.nameComponents?.givenName else{
                    throw CloudKitError.nameNotFound
                }
            }catch{
                print(error)
            }
        }
    }
    
    // CRUD
    
    func saveItems(){
        Task{
            do{
                try await manager.addItem(phrase: "TESTE TESTE TESTE", recordType: "phrases")
            }catch{
                print(error)
            }
        }
    }
    
    func fetchItems(){
        Task{
            do{
              let response = try await manager.fetchItems(recordType: "phrases")
             
            try response.map { (_,result) in
                 switch result{
                 case .success(let record):
                  let items =  record.value(forKey: "phrases")
                     DispatchQueue.main.async {
                         self.fetchedItems.append(items as! String)
                     }
                 case .failure(let error):
                     throw error
                 }
                }
            }catch{
                print(error)
            }
        }
    }
}

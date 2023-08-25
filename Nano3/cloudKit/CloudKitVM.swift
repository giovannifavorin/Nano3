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
//    var id: CKRecord.ID
    
    
    init(){
        fetchPermission()
        fetchStatus()
//        fetchID()
        fetchUserName()
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
}

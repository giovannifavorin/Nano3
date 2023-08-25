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
    
    init(){
//        fetchStatus()
        fetchID()
        fetchPermission()
    }
    
    @Published var text:String = ""
    var manager = CloudKitModel()
    
    
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
                print(response.rawValue.description)
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
                
            }catch{
                print(error)
            }
        }
    }
}

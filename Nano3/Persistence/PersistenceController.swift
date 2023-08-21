//
//  PersistenceController.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import CloudKit
import CoreData

struct PersistenceController{
    
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Model")
        
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            
            if let error = error as NSError?{
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
}

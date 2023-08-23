//
//  PersistenceController.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 21/08/23.
//

import CloudKit
import CoreData
import SwiftUI

class PersistenceController : ObservableObject {
    
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer
    @Published var savedQuotes: [Banco] = []
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Model")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchQuotes()
        } catch {
            print("Error saving data")
        }
    }
    
    func fetchQuotes() {
        let request = NSFetchRequest<Banco>(entityName: "Banco")
        
        do {
            try savedQuotes = container.viewContext.fetch(request)
        }catch {
            print("Erro saving data")
        }
    }
    
    func addQuote(quote : APIResponse) {
        let newQuote = Banco(context: container.viewContext)
        newQuote.frase = quote.q
        newQuote.autor = quote.a
        newQuote.uuid = UUID()
        saveData()
    }
    
    func deleteObject(index : IndexSet) {
        let indexDeleted = index.first!
        container.viewContext.delete(savedQuotes[indexDeleted])
        saveData()
    }
    
    func removeBanco(at offsets: IndexSet, bancos: FetchedResults<Banco>, moc:NSManagedObjectContext) {
        withAnimation {
            offsets.map { bancos[$0] }.forEach(moc.delete)
            do {
                try moc.save()
            } catch{
                print("Azedou")
            }
        }
    }
}

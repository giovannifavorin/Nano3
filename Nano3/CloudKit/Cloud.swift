//
//  Cloud.swift
//  Nano3
//
//  Created by Arthur Dos Reis on 28/08/23.
//

import CloudKit
import CoreData

struct FrasesModel: Hashable{
    
    let frase: String
    let autor: String
    let record: CKRecord
}

class Cloud: ObservableObject{
    
    @Published var frases:[FrasesModel] = []
    
    let banco: PersistenceController = PersistenceController()
    
    init(){
        
        fetchItems()
        
    }
    

    func addItem(item: APIResponse){
        let novaFrase = CKRecord(recordType: "Frases")
        novaFrase["frase"] = item.q
        novaFrase["autor"] = item.a
        saveItem(record: novaFrase)
    }
    private func saveItem(record:CKRecord){
        CKContainer.default().publicCloudDatabase.save(record) { rec, err in
            print("Record: \(String(describing: rec))")
            print("Error: \(String(describing: err))")
        }
    }
    
    // Adicionei 'async' aqui, tornando a função assíncrona
    func fetchItems() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Frases", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
     
        var returnedItems:[FrasesModel] = []

        queryOperation.recordMatchedBlock = { (returnedID, returnedResult) in
            switch returnedResult {
            case .success(let record):
                guard let frase = record["frase"] as? String, let name = record["autor"] as? String else { return }
                self.banco.container.viewContext.perform { [unowned self] in
                    let fetchRequest: NSFetchRequest<Banco> = Banco.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "frase == %@", record["frase"] as! String)
                    
                    do {
                        let frasesEncontradas = try self.banco.container.viewContext.fetch(fetchRequest)
                        if frasesEncontradas.isEmpty {
                            // Adicionei 'try' aqui
                            try self.banco.addQuote(quote: APIResponse(q: frase, a: name))
                        }
                    } catch {
                        print("Erro ao buscar: \(error)")
                    }
                    self.banco.saveData()
                }
                returnedItems.append(FrasesModel(frase: frase, autor: name, record: record))
            case .failure(let error):
                print("Error recordMatchedBlock: \(error)")
            }
        }

        queryOperation.queryResultBlock = { [weak self] returnedResult in
            print("Returned Result: \(returnedResult)")
            DispatchQueue.main.async {
                
                self?.frases = returnedItems

            }
        }
        
        addOperation(operation: queryOperation)
    }

    
    func addOperation(operation: CKDatabaseOperation) {
        
         CKContainer.default().publicCloudDatabase.add(operation)
        
    }
    
    func deleteItems(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let frase = frases[index]
        let record = frase.record
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self] returnedID, returnedError in
            DispatchQueue.main.async {
                self?.frases.remove(at: index)
            }
        }
    }
    
}

//
//  CloudKitVM.swift
//  Nano3
//
//  Created by Gabriel Eirado on 24/08/23.
//

import Foundation
import CloudKit


class CloudKitModel {
    
    var isSignedIn: Bool = false
    var signInError: String = ""
    var userName: String = ""
    var permissionStatus: Bool = false
    
    init(){
        //        getIcloudStatus()
        //        getPermission()
        //        getUserID()
    }
    
    func getUserID() async throws -> CKRecord.ID{
        let fetchUserID = try await CKContainer.default().userRecordID()
        return fetchUserID
    }
    
    func getIcloudName(id: CKRecord.ID){
        CKContainer.default().discoverUserIdentity(withUserRecordID: id){ [weak self] userName, error in
            DispatchQueue.main.async {
                if let name = userName?.nameComponents?.givenName{
                    self?.userName = name
                }
            }
        }
    }
    
    func getIcloudStatus() async throws -> CKAccountStatus{
        let accountStatus = try await CKContainer.default().accountStatus()
        switch accountStatus{
        case .available:
            return CKAccountStatus.available
        case .noAccount:
            throw CloudKitError.accountNotfound
        case .couldNotDetermine:
            throw CloudKitError.accountNotDetermined
        case .restricted:
            throw  CloudKitError.accountRestricted
        default:
            throw CloudKitError.accountUnknow
        }
    }
    
    
    func getPermission() async throws -> CKContainer.ApplicationPermissionStatus{
        
        let permission = try await CKContainer.default().requestApplicationPermission([.userDiscoverability])
        
        switch permission{
        case .granted:
            return CKContainer.ApplicationPermissionStatus.granted
        case .couldNotComplete:
            throw CKError(.internalError)
        case .denied:
            throw CKError(.permissionFailure)
        case .initialState:
            return CKContainer.ApplicationPermissionStatus.initialState
        default:
            fatalError("UNKNOW ERROR!!")
        }
    }
    
    
    func buttonPressed(text: String) {
        guard !text.isEmpty else{ return }
        addItem(phrase: text)
    }
    
    func addItem(phrase: String){
        let item = CKRecord(recordType: "phrases")
        item["phrase"] = phrase
        saveItem(record: item)
    }
    
    func saveItem(record: CKRecord){
        CKContainer.default().publicCloudDatabase.save(record) { reurnedRecord, error in
            print("record: \(String(describing: reurnedRecord))")
            print("error to save: \(String(describing: error))")
        }
    }
    
    func fetchItems(){
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "phrases", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        var returnedItems: [String] = []
        
        queryOperation.recordMatchedBlock = { (recordID,result) in
            switch result{
            case .success(let record):
                guard let name = record["phrase"] as? String else { return }
                returnedItems.append(name)
                
            case .failure(let error):
                print("error matchedBlock: \(error)")
            }
        }
        
        queryOperation.queryResultBlock = { result in
            print("query result \(result)")
            
        }
        
        addOperation(operation: queryOperation)
    }
    
    func addOperation(operation: CKDatabaseOperation){
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}

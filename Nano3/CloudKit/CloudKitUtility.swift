//
//  CloudKitVM.swift
//  Nano3
//
//  Created by Gabriel Eirado on 24/08/23.
//

import Foundation
import CloudKit



class CloudKitUtility {
    
    func getUserID() async throws -> CKRecord.ID{
        let fetchUserID = try await CKContainer.default().userRecordID()
        return fetchUserID
    }
    
    func getIcloudName(id: CKRecord.ID) async throws -> CKUserIdentity?{
        let name = try await CKContainer.default().userIdentity(forUserRecordID: id)
          return name
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
            return CKContainer.ApplicationPermissionStatus.denied
        default:
            fatalError("UNKNOW ERROR!!")
        }
    }
    
    func addItem(phrase: String, recordType: String) async throws{
       
        let item = CKRecord(recordType: recordType)
        item[recordType] = phrase
        try await CKContainer.default().publicCloudDatabase.save(item)
    }

    
    func fetchItems(recordType: String) async throws -> [(CKRecord.ID, Result<CKRecord, any Error>)]{
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        let container = CKContainer.default().publicCloudDatabase

        let (notesResults, _) = try await container.records(matching: query,
                                                                resultsLimit: 100)
        
            return notesResults
    }
    
    func deleteItems(recordType: String) async throws{
//        try await CKContainer.default().privateCloudDatabase.deleteRecord(withID: recordType.recordID)
    }
     
}


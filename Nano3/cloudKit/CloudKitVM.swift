//
//  CloudKitVM.swift
//  Nano3
//
//  Created by Gabriel Eirado on 24/08/23.
//

import Foundation
import CloudKit


class CloudKitVM: ObservableObject{
    
    @Published var isSignedIn: Bool = false
    @Published var signInError: String = ""
    @Published var userName: String = ""
    @Published var permissionStatus: Bool = false
    
    init(){
//        getIcloudStatus()
        getPermission()
//        getUserID()
    }
    
    func getUserID(){
        CKContainer.default().fetchUserRecordID { [weak self] userID, error in
            if let ID = userID{
                self?.getIcloudName(id: ID)
            }
        }
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
    
    func getIcloudStatus(){
        CKContainer.default().accountStatus { accountStatus, error in
            DispatchQueue.main.async {
                switch accountStatus{
                case .available:
                    self.isSignedIn = true
                case .noAccount:
                    self.signInError = CloudKitError.accountNotfound.rawValue
                case .couldNotDetermine:
                    self.signInError =  CloudKitError.accountNotDetermined.rawValue
                case .restricted:
                    self.signInError =  CloudKitError.accountRestricted.rawValue
                default:
                    self.signInError =  CloudKitError.accountUnknow.rawValue
                    
                    
                }
            }
        }
    }
    
    func getPermission(){
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] permissionStatus, error in
            DispatchQueue.main.async {
                if permissionStatus == .granted{
                    self?.permissionStatus = true
                }
            }
        }
    }
}

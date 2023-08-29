//
//  UserModel.swift
//  Nano3
//
//  Created by Daniel Ishida on 28/08/23.
//

import Foundation
import CloudKit

struct User{
    var userName:String
    var userID: CKRecord.ID
    var quotes: [Quote]
}

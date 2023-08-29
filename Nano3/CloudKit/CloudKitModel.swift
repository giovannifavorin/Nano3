//
//  CloudKitModel.swift
//  Nano3
//
//  Created by Gabriel Eirado on 29/08/23.
//

import Foundation
import CloudKit

struct CloudKitModel: Hashable{
    let phrase: String
    let recordID: CKRecord // not the ideal way
}

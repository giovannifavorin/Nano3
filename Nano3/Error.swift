//
//  Error.swift
//  Nano3
//
//  Created by Gabriel Eirado on 21/08/23.
//

import Foundation


enum APIError: Error {
    case invalidURL
    case invalidResponse(String)
    case invalidData(String)
}

enum CloudKitError: String, Error{
    case accountNotfound
    case accountNotDetermined
    case accountRestricted
    case accountUnknow
    case nameNotFound
}

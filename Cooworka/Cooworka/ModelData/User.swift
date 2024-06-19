//
//  User.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct User{
    
    var userID: CKRecord.ID
    var username: String
    var xp: Int
    var emailUser: String
    
    init(userID: CKRecord.ID? = nil, username: String, xp: Int, emailUser: String) {
        self.userID = userID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.username = username
        self.xp = xp
        self.emailUser = emailUser
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "userID": userID,
                "username": username,
                "xp": xp,
                "emailUser": emailUser
            ]
        }
    
}

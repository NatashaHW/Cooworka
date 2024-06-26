//
//  User.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct User: CloudKitRecord{
    var recordID: CKRecord.ID?
    var userID: String
    var firstName: String
    var lastName: String
    var xp: Int
    var emailUser: String
    
    init(userID: String, firstName: String, lastName: String, xp: Int, emailUser: String) {
        self.userID = userID
        self.recordID = CKRecord.ID(recordName: userID)
        self.firstName = firstName
        self.lastName = lastName
        self.xp = xp
        self.emailUser = emailUser
    }
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.userID = record["userID"] as? String ?? ""
        self.firstName = record["firstName"] as? String ?? ""
        self.lastName = record["lastName"] as? String ?? ""
        self.xp = record["xp"] as? Int ?? 0
        self.emailUser = record["emailUser"] as? String ?? ""
    }
    
    
    func toDictionary() -> [String: Any] {
            return [
                "userID": userID,
                "firstName": firstName,
                "lastName": lastName,
                "xp": xp,
                "emailUser": emailUser
            ]
        }
    

    func toCKRecord(recordType: String) -> CKRecord {
            let record = CKRecord(recordType: recordType, recordID: recordID!)
            record["firstName"] = firstName as CKRecordValue
            record["lastName"] = lastName as CKRecordValue
            record["xp"] = xp as CKRecordValue
            record["emailUser"] = emailUser as CKRecordValue
            return record
        }
    
}
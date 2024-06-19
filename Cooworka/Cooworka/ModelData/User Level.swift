//
//  User Level.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct UserLevel: CloudKitRecord{
    var recordID: CKRecord.ID?
    let userLevelID: CKRecord.ID
    let userReference: CKRecord.Reference
    let levelReference: CKRecord.Reference
    
    init(userLevelID: CKRecord.ID? = nil, userReference: CKRecord.ID, levelReference: CKRecord.ID) {
        self.userLevelID = userLevelID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.recordID = userLevelID
        self.userReference = CKRecord.Reference(recordID: userReference, action: .deleteSelf)
        self.levelReference = CKRecord.Reference(recordID: levelReference, action: .deleteSelf)
        
    }
    
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.userLevelID = record.recordID
        self.userReference = record["userReference"] as! CKRecord.Reference
        self.levelReference = record["levelReference"] as! CKRecord.Reference
    }
    
    
    func toDictionary() -> [String: Any] {
        return [
            "userLevelID": userLevelID.recordName,
            "userReference": userReference,
            "levelReference": levelReference
        ]
    }
    
    func toCKRecord(recordType: String) -> CKRecord {
        let record = CKRecord(recordType: recordType, recordID: userLevelID)
        record["userReference"] = userReference
        record["levelReference"] = levelReference
        return record
    }
    
    
}

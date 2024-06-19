//
//  Level.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Level: CloudKitRecord{
    var recordID: CKRecord.ID?
    let levelID: CKRecord.ID
    let levelName: String
    let minimumXp: Int
    
    init(levelID: CKRecord.ID? = nil, levelName: String, minimumXp: Int) {
        self.levelID = levelID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.recordID = levelID
        self.levelName = levelName
        self.minimumXp = minimumXp
    }
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.levelID = record.recordID
        self.levelName = record["levelName"] as? String ?? ""
        self.minimumXp = record["minimumXp"] as? Int ?? 0
    }
    
    
    func toDictionary() -> [String: Any] {
        return [
            "levelID": levelID.recordName,
            "levelName": levelName,
            "minimumXp": minimumXp
        ]
    }
    
    func toCKRecord(recordType: String) -> CKRecord {
        let record = CKRecord(recordType: recordType, recordID: levelID)
        record["levelName"] = levelName as CKRecordValue
        record["minimumXp"] = minimumXp as CKRecordValue
        return record
    }
    
}

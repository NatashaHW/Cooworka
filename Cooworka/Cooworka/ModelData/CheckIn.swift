//
//  Check In.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct CheckIn: CloudKitRecord{
    
    var recordID: CKRecord.ID?
    var checkInID: CKRecord.ID
    var checkInDate: Date
    var cafeReference: CKRecord.Reference
    var userReference: CKRecord.Reference
    
    init(checkInDate: Date, cafeReference: CKRecord.ID, userReference: CKRecord.ID) {
        self.checkInID = CKRecord.ID(recordName: UUID().uuidString)
        self.recordID = checkInID
        self.checkInDate = checkInDate
        self.cafeReference = CKRecord.Reference(recordID: cafeReference, action: .deleteSelf)
        self.userReference = CKRecord.Reference(recordID: userReference, action: .deleteSelf)
    }
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.checkInID = record.recordID
        self.checkInDate = record["checkInDate"] as? Date ?? Date()
        self.cafeReference = (record["cafeReference"] as? CKRecord.Reference)!
        self .userReference = (record["userReference"] as? CKRecord.Reference)!
        
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "checkInID": checkInID.recordName,
                "checkInDate": checkInDate,
                "cafeReference": cafeReference,
                "userReference": userReference
            ]
        }
    

    
    func toCKRecord(recordType: String) -> CKRecord {
        let record = CKRecord(recordType: recordType, recordID: checkInID)
        record["checkInID"] = checkInID.recordName as CKRecordValue
        record["checkInDate"] = checkInDate as CKRecordValue
        record["cafeReference"] = cafeReference
        record["userReference"] = userReference
        return record
    }
    
    
    
}

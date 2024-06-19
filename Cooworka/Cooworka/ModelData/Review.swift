//
//  Review.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Review: CloudKitRecord{
    var recordID: CKRecord.ID?
    let reviewID: CKRecord.ID
    var reviewDate: Date
    var tasteScale: Float
    var ambienceScale: Float
    var spendingRange: String
    var wifiCondition: Float
    var socketQty: Float
    var chairTableScale: Float
    var cleanScale: Float
    var safetyScale: Float
    var custServiceScale: Float
    var description: String
    var userReference: CKRecord.Reference
    var cafeReference: CKRecord.Reference
    var checkInReference: CKRecord.Reference
    
    init(reviewID: CKRecord.ID? = nil, reviewDate: Date, tasteScale: Float, ambienceScale: Float, spendingRange: String, wifiCondition: Float, socketQty: Float, chairTableScale: Float, cleanScale: Float, safetyScale: Float, custServiceScale: Float, description: String, userReference: CKRecord.Reference, cafeReference: CKRecord.Reference, checkInReference: CKRecord.Reference) {
        self.reviewID = reviewID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.reviewDate = reviewDate
        self.tasteScale = tasteScale
        self.ambienceScale = ambienceScale
        self.spendingRange = spendingRange
        self.wifiCondition = wifiCondition
        self.socketQty = socketQty
        self.chairTableScale = chairTableScale
        self.cleanScale = cleanScale
        self.safetyScale = safetyScale
        self.custServiceScale = custServiceScale
        self.description = description
        self.userReference = userReference
        self.cafeReference = cafeReference
        self.checkInReference = checkInReference
        
    }
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.reviewID = record.recordID
        self.reviewDate = record["reviewDate"] as? Date ?? Date()
        self.tasteScale = record["tasteScale"] as? Float ?? 0.0
        self.ambienceScale = record["ambienceScale"] as? Float ?? 0.0
        self.spendingRange = record["spendingRange"] as? String ?? ""
        self.wifiCondition = record["wifiCondition"] as? Float ?? 0.0
        self.socketQty = record["socketQty"] as? Float ?? 0.0
        self.chairTableScale = record["chairTableScale"] as? Float ?? 0.0
        self.cleanScale = record["cleanScale"] as? Float ?? 0.0
        self.safetyScale = record["safetyScale"] as? Float ?? 0.0
        self.custServiceScale = record["custServiceScale"] as? Float ?? 0.0
        self.description = record["description"] as? String ?? ""
        self.userReference = (record["userReference"] as? CKRecord.Reference)!
        self.cafeReference = (record["cafeReference"] as? CKRecord.Reference)!
        self.checkInReference = (record["checkInReference"] as? CKRecord.Reference)!
    }
    
    
    func toDictionary() -> [String: Any] {
        return [
            "reviewID": reviewID.recordName,
            "reviewDate": reviewDate,
            "tasteScale": tasteScale,
            "ambienceScale": ambienceScale,
            "spendingRange": spendingRange,
            "wifiCondition": wifiCondition,
            "socketQty": socketQty,
            "chairTableScale": chairTableScale,
            "cleanScale": cleanScale,
            "safetyScale": safetyScale,
            "custServiceScale": custServiceScale,
            "description": description,
            "userReference": userReference,
            "cafeReference": cafeReference,
            "checkInReference": checkInReference
            
        ]
    }
    
    func toCKRecord(recordType: String) -> CKRecord {
        let record = CKRecord(recordType: recordType, recordID: reviewID)
        record["reviewDate"] = reviewDate as CKRecordValue
        record["tasteScale"] = tasteScale as CKRecordValue
        record["ambienceScale"] = ambienceScale as CKRecordValue
        record["spendingRange"] = spendingRange as CKRecordValue
        record["wifiCondition"] = wifiCondition as CKRecordValue
        record["socketQty"] = socketQty as CKRecordValue
        record["chairTableScale"] = chairTableScale as CKRecordValue
        record["cleanScale"] = cleanScale as CKRecordValue
        record["safetyScale"] = safetyScale as CKRecordValue
        record["custServiceScale"] = custServiceScale as CKRecordValue
        record["description"] = description as CKRecordValue
        record["userReference"] = userReference
        record["cafeReference"] = cafeReference
        record["checkInReference"] = checkInReference
        return record
    }
    
    
}

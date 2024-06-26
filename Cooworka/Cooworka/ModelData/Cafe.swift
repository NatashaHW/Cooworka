//
//  Cafe.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Cafe: CloudKitRecord{
    var recordID: CKRecord.ID?
    var cafeID: CKRecord.ID
    let alamatCafe: String
    let namaCafe: String
    let jamBuka: String
    let jamTutup: String
    var tasteRating: Float
    var serviceRating: Float
    var ambienceRating: Float
    
    init(alamatCafe: String, namaCafe: String, jamBuka: String, jamTutup: String, tasteRating: Float, serviceRating: Float, ambienceRating: Float) {
        self.cafeID = CKRecord.ID(recordName: UUID().uuidString)
        self.recordID = cafeID
        self.alamatCafe = alamatCafe
        self.namaCafe = namaCafe
        self.jamBuka = jamBuka
        self.jamTutup = jamTutup
        self.tasteRating = tasteRating
        self.serviceRating = serviceRating
        self.ambienceRating = ambienceRating
    }
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.cafeID = record.recordID
        self.alamatCafe = record["alamatCafe"] as? String ?? ""
        self.namaCafe = record["namaCafe"] as? String ?? ""
        self.jamBuka = record["jamBuka"] as? String ?? ""
        self.jamTutup = record["jamTutup"] as? String ?? ""
        self.tasteRating = record["tasteRating"] as? Float ?? 0.0
        self.serviceRating = record["serviceRating"] as? Float ?? 0.0
        self.ambienceRating = record["ambienceRating"] as? Float ?? 0.0
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "cafeID": cafeID.recordName,
                "alamatCafe": alamatCafe,
                "namaCafe": namaCafe,
                "jamBuka": jamBuka,
                "jamTutup": jamTutup,
                "tasteRating": tasteRating,
                "serviceRating": serviceRating,
                "ambienceRating": ambienceRating
            ]
        }
    
    func toCKRecord(recordType: String) -> CKRecord {
        let record = CKRecord(recordType: recordType, recordID: recordID!)
        record["cafeID"] = cafeID.recordName as CKRecordValue
        record["alamatCafe"] = alamatCafe as CKRecordValue
        record["namaCafe"] = namaCafe as CKRecordValue
        record["jamBuka"] = jamBuka as CKRecordValue
        record["jamTutup"] = jamTutup as CKRecordValue
        record["tasteRating"] = tasteRating as CKRecordValue
        record["serviceRating"] = serviceRating as CKRecordValue
        record["ambienceRating"] = ambienceRating as CKRecordValue
        return record
    }
    
    
}

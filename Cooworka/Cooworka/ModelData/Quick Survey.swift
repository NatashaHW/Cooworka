//
//  Quick Survey.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct QuickSurvey: CloudKitRecord{
    var recordID: CKRecord.ID?
    let quickSurveyID: CKRecord.ID
    let quickSurveyDate: Date
    let isMainDish: Bool
    let isMeetingRoom: Bool
    let isPrayerRoom: Bool
    let isSmokingArea: Bool
    let isCarParking: Bool
    let isMotorParking: Bool
    let isCash: Bool
    let isCashless: Bool
    var userReference: CKRecord.Reference
    var cafeReference: CKRecord.Reference
    var checkInReference: CKRecord.Reference
    
    init(quickSurveyDate: Date, isMainDish: Bool, isMeetingRoom: Bool, isPrayerRoom: Bool, isSmokingArea: Bool, isCarParking: Bool, isMotorParking: Bool, isCash: Bool, isCashless: Bool, userReference: CKRecord.ID, cafeReference: CKRecord.ID, checkInReference: CKRecord.ID) {
        self.quickSurveyID = CKRecord.ID(recordName: UUID().uuidString)
        self.recordID = quickSurveyID
        self.quickSurveyDate = quickSurveyDate
        self.isMainDish = isMainDish
        self.isMeetingRoom = isMeetingRoom
        self.isPrayerRoom = isPrayerRoom
        self.isSmokingArea = isSmokingArea
        self.isCarParking = isCarParking
        self.isMotorParking = isMotorParking
        self.isCash = isCash
        self.isCashless = isCashless
        self.userReference = CKRecord.Reference(recordID: userReference, action: .deleteSelf)
        self.cafeReference = CKRecord.Reference(recordID: cafeReference, action: .deleteSelf)
        self.checkInReference = CKRecord.Reference(recordID: checkInReference, action: .deleteSelf)
    }
    
    init(record: CKRecord) {
            self.recordID = record.recordID
            self.quickSurveyID = record.recordID
            self.quickSurveyDate = record["quickSurveyDate"] as? Date ?? Date()
            self.isMainDish = record["isMainDish"] as? Bool ?? false
            self.isMeetingRoom = record["isMeetingRoom"] as? Bool ?? false
            self.isPrayerRoom = record["isPrayerRoom"] as? Bool ?? false
            self.isSmokingArea = record["isSmokingArea"] as? Bool ?? false
            self.isCarParking = record["isCarParking"] as? Bool ?? false
            self.isMotorParking = record["isMotorParking"] as? Bool ?? false
            self.isCash = record["isCash"] as? Bool ?? false
            self.isCashless = record["isCashless"] as? Bool ?? false
            self.userReference = (record["userReference"] as? CKRecord.Reference)!
            self.cafeReference = (record["cafeReference"] as? CKRecord.Reference)!
            self.checkInReference = (record["checkInReference"] as? CKRecord.Reference)!
        }
    
    
    
    func toDictionary() -> [String: Any] {
            return [
                "quickSurveyID": quickSurveyID.recordName,
                "quickSurveyDate": quickSurveyDate,
                "isMainDish": isMainDish,
                "isMeetingRoom": isMeetingRoom,
                "isPrayerRoom": isPrayerRoom,
                "isSmokingArea": isSmokingArea,
                "isCarParking": isCarParking,
                "isMotorParking": isMotorParking,
                "isCash": isCash,
                "isCashless": isCashless,
                "userReference": userReference,
                "cafeReference": cafeReference,
                "checkInReference": checkInReference
            ]
        }
    
    func toCKRecord(recordType: String) -> CKRecord {
            let record = CKRecord(recordType: recordType, recordID: quickSurveyID)
            record["quickSurveyDate"] = quickSurveyDate as CKRecordValue
            record["isMainDish"] = isMainDish as CKRecordValue
            record["isMeetingRoom"] = isMeetingRoom as CKRecordValue
            record["isPrayerRoom"] = isPrayerRoom as CKRecordValue
            record["isSmokingArea"] = isSmokingArea as CKRecordValue
            record["isCarParking"] = isCarParking as CKRecordValue
            record["isMotorParking"] = isMotorParking as CKRecordValue
            record["isCash"] = isCash as CKRecordValue
            record["isCashless"] = isCashless as CKRecordValue
            record["userReference"] = userReference
            record["cafeReference"] = cafeReference
            record["checkInReference"] = checkInReference
            return record
        }
    
}

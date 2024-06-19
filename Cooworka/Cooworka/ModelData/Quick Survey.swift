//
//  Quick Survey.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct QuickSurvey{
    
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
    
    init(quickSurveyID: CKRecord.ID? = nil, quickSurveyDate: Date, isMainDish: Bool, isMeetingRoom: Bool, isPrayerRoom: Bool, isSmokingArea: Bool, isCarParking: Bool, isMotorParking: Bool, isCash: Bool, isCashless: Bool) {
        self.quickSurveyID = quickSurveyID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.quickSurveyDate = quickSurveyDate
        self.isMainDish = isMainDish
        self.isMeetingRoom = isMeetingRoom
        self.isPrayerRoom = isPrayerRoom
        self.isSmokingArea = isSmokingArea
        self.isCarParking = isCarParking
        self.isMotorParking = isMotorParking
        self.isCash = isCash
        self.isCashless = isCashless
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
                "isCashless": isCashless
            ]
        }
    
}

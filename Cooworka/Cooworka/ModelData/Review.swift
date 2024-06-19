//
//  Review.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Review{
    
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
    
    init(reviewID: CKRecord.ID? = nil, reviewDate: Date, tasteScale: Float, ambienceScale: Float, spendingRange: String, wifiCondition: Float, socketQty: Float, chairTableScale: Float, cleanScale: Float, safetyScale: Float, custServiceScale: Float, description: String) {
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
                "description": description
            ]
        }
    
}

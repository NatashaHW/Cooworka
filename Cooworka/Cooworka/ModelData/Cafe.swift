//
//  Cafe.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Cafe{
    
    var cafeID: CKRecord.ID
    let alamatCafe: String
    let namaCafe: String
    let jamBuka: String
    let jamTutup: String
    var tasteRating: Float
    var serviceRating: Float
    var ambienceRating: Float
    
    init(cafeID: CKRecord.ID? = nil, alamatCafe: String, namaCafe: String, jamBuka: String, jamTutup: String, tasteRating: Float, serviceRating: Float, ambienceRating: Float) {
        self.cafeID = cafeID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.alamatCafe = alamatCafe
        self.namaCafe = namaCafe
        self.jamBuka = jamBuka
        self.jamTutup = jamTutup
        self.tasteRating = tasteRating
        self.serviceRating = serviceRating
        self.ambienceRating = ambienceRating
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "cafeID": cafeID,
                "alamatCafe": alamatCafe,
                "namaCafe": namaCafe,
                "jamBuka": jamBuka,
                "jamTutup": jamTutup,
                "tasteRating": tasteRating,
                "serviceRating": serviceRating,
                "ambienceRating": ambienceRating
            ]
        }
    
    
}

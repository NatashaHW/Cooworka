//
//  Check In.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct CheckIn{
    
    var checkInID: CKRecord.ID
    let checkInDate: Date
    
    init(checkInID: CKRecord.ID? = nil, checkInDate: Date) {
        self.checkInID = checkInID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.checkInDate = checkInDate
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "checkInID" : checkInID,
                "checkInDate": checkInDate
            ]
        }
    
}

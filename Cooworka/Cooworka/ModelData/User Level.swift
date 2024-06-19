//
//  User Level.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct UserLevel{
    
    let userLevelID: CKRecord.ID
    let userID: CKRecord.Reference
    let levelID: CKRecord.Reference
    
    init(userLevelID: CKRecord.ID? = nil, userID: CKRecord.ID, levelID: CKRecord.ID) {
            self.userLevelID = userLevelID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.userID = CKRecord.Reference(recordID: userID, action: .deleteSelf)
        self.levelID = CKRecord.Reference(recordID: levelID, action: .deleteSelf)
        
        }
        
        func toDictionary() -> [String: Any] {
            return [
                "userLevelID": userLevelID.recordName,
                "userID": userID,
                "levelID": levelID
            ]
        }
    
    
}

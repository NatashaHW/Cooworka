//
//  Level.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Level{
    
    let levelID: CKRecord.ID
    let levelName: String
    let minimumXp: Int
    
    init(levelID: CKRecord.ID? = nil, levelName: String, minimumXp: Int) {
        self.levelID = levelID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.levelName = levelName
        self.minimumXp = minimumXp
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "levelID": levelID,
            "levelName": levelName,
            "minimumXp": minimumXp
        ]
    }
    
}

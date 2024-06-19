//
//  Foto.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Foto{
    
    let fotoID: CKRecord.ID
    let foto: CKAsset
    
    init(fotoID: CKRecord.ID? = nil, foto: CKAsset) {
        self.fotoID = fotoID ?? CKRecord.ID(recordName: UUID().uuidString)
        self.foto = foto
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "fotoID": fotoID,
            "foto": foto
        ]
    }
    
}

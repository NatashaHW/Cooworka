//
//  Foto.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 18/06/24.
//

import Foundation
import CloudKit

struct Foto: CloudKitRecord{
    var recordID: CKRecord.ID?
    let fotoID: CKRecord.ID
    let foto: CKAsset
    var reviewReference: CKRecord.Reference
    
    init(foto: CKAsset, reviewReference: CKRecord.ID) {
        self.fotoID = CKRecord.ID(recordName: UUID().uuidString)
        self.recordID = fotoID
        self.foto = foto
        self.reviewReference = CKRecord.Reference(recordID: reviewReference, action: .deleteSelf)
    }
    
    
    init(record: CKRecord) {
        self.recordID = record.recordID
        self.fotoID = record.recordID
        self.foto = record["foto"] as! CKAsset
        self.reviewReference = record["reviewReference"] as! CKRecord.Reference
    }
    
    
    func toDictionary() -> [String: Any] {
        return [
            "fotoID": fotoID.recordName,
            "foto": foto,
            "reviewReference": reviewReference
        ]
    }
    
    func toCKRecord(recordType: String) -> CKRecord {
        let record = CKRecord(recordType: recordType, recordID: fotoID)
        record["foto"] = foto
        record["reviewReference"] = reviewReference
        return record
    }
    
}

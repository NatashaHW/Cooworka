//
//  CloudKitRecord.swift
//  Cooworka
//
//  Created by Sherly Phangestu on 19/06/24.
//

import CloudKit

protocol CloudKitRecord {
    var recordID: CKRecord.ID? { get set }
    init(record: CKRecord)
    func toCKRecord(recordType: String) -> CKRecord
}

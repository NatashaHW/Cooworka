//
//  CloudKitManager.swift
//  Cooworka
//
//  Created by Sherly Phangestu on 19/06/24.
//

import CloudKit

class CloudKitManager<T: CloudKitRecord> {
    private var database: CKDatabase
    
    init() {
        self.database = CKContainer.(identifier:"iCloud.ADA.mini2.cooworka.app").publicCloudDatabase
    }
    
    func save(record: T, recordType: String, completion: @escaping (Result<T, Error>) -> Void) {
        let ckRecord = record.toCKRecord(recordType: recordType)
        
        database.save(ckRecord) { savedRecord, error in
            if let error = error {
                completion(.failure(error))
            } else if let savedRecord = savedRecord {
                let savedModel = T(record: savedRecord)
                completion(.success(savedModel))
            }
        }
    }
    
    func fetch(recordType: String, completion: @escaping (Result<[T], Error>) -> Void) {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(.failure(error))
            } else if let records = records {
                let models = records.map { T(record: $0) }
                completion(.success(models))
            }
        }
    }
    
    func delete(recordID: CKRecord.ID, completion: @escaping (Result<Void, Error>) -> Void) {
        database.delete(withRecordID: recordID) { recordID, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func search(recordType: String, withTitle title: String, completion: @escaping (Result<[T], Error>) -> Void) {
        let predicate = NSPredicate(format: "title CONTAINS[c] %@", title)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        
        database.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(.failure(error))
            } else if let records = records {
                let models = records.map { T(record: $0) }
                completion(.success(models))
            }
        }
    }
}

//
//  CafeRepository.swift
//  Cooworka
//
//  Created by Sherly Phangestu on 19/06/24.
//

import CloudKit

class CafeRepository {
    private var cloudKitManager: CloudKitManager<Cafe>
    
    init(cloudKitManager: CloudKitManager<Cafe> = CloudKitManager<Cafe>()) {
        self.cloudKitManager = cloudKitManager
    }
    
    func save(cafe: Cafe, completion: @escaping (Result<Cafe, Error>) -> Void) {
        cloudKitManager.save(record: cafe, recordType: "Cafe", completion: completion)
    }
    
    func fetchCafes(completion: @escaping (Result<[Cafe], Error>) -> Void) {
        cloudKitManager.fetch(recordType: "Cafe", completion: completion)
    }
    
    func delete(cafe: Cafe, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let recordID = cafe.recordID else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid record ID"])))
            return
        }
        cloudKitManager.delete(recordID: recordID, completion: completion)
    }
    
    func searchCafes(withTitle title: String, completion: @escaping (Result<[Cafe], Error>) -> Void) {
        cloudKitManager.search(recordType: "Cafe", withTitle: title, completion: completion)
    }
}


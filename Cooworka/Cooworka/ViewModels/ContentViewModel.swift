//
//  ContentViewModel.swift
//  Cooworka
//
//  Created by Sherly Phangestu on 19/06/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var cafeList: [Cafe] = []
    @Published var searchText: String = ""
    private var cafeRepository: CafeRepository = CafeRepository()
    
    init() {
        fetchCafes()
    }
    
    func saveCafe() {
        let newCafe = Cafe(
                        alamatCafe : "",
                        namaCafe : "namaCafe",
                        jamBuka : "00:00",
                        jamTutup : "00:00",
                        tasteRating : 5.0,
                        serviceRating : 5.0,
                        ambienceRating : 5.0
                    )
        cafeRepository.save(cafe: newCafe) { result in
            switch result {
            case .success(let savedCafe):
                DispatchQueue.main.async {
                    self.cafeList.append(savedCafe)
                }
            case .failure(let error):
                print("Failed to save cafe: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCafes() {
        cafeRepository.fetchCafes { result in
            switch result {
            case .success(let fetchedCafes):
                DispatchQueue.main.async {
                    self.cafeList = fetchedCafes
                }
            case .failure(let error):
                print("Failed to fetch cafes: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteCafe(cafe: Cafe) {
        cafeRepository.delete(cafe: cafe) { result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self.cafeList.removeAll { $0.cafeID == cafe.cafeID }
                }
            case .failure(let error):
                print("Failed to delete cafe: \(error.localizedDescription)")
            }
        }
    }
    
    func searchCafes() {
        cafeRepository.searchCafes(withTitle: searchText) { result in
            switch result {
            case .success(let searchedCafes):
                DispatchQueue.main.async {
                    self.cafeList = searchedCafes
                }
            case .failure(let error):
                print("Failed to search cafes: \(error.localizedDescription)")
            }
        }
    }
}

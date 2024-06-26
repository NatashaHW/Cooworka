////
////  Level.swift
////  Cooworka
////
////  Created by Lucinda Artahni on 24/06/24.
////
//
import Foundation

struct LevelProfileModel {
    var levelName: String //TODO: ada tambahan ini
    var imageName: String
    var pointsToUnlock: Int
    var noLevel: Int
}

var Levels: [LevelProfileModel] = [
    .init(levelName: "Budak Jompo", imageName: "BudakJompo", pointsToUnlock: 1000, noLevel: 1),
    .init(levelName: "Pemburu Deadline", imageName: "Unknown" , pointsToUnlock: 2000, noLevel: 2),
    .init(levelName: "Pengintai Barista", imageName: "Unknown", pointsToUnlock: 4000, noLevel: 3),
    .init(levelName: "Ahli Burnout", imageName: "Unknown", pointsToUnlock: 8000, noLevel: 4),
    .init(levelName: "Ksatria Kafein", imageName: "Unknown", pointsToUnlock: 16000, noLevel: 5),
    .init(levelName: "Raja Gila Kerja", imageName: "Unknown", pointsToUnlock: 32000, noLevel: 6),
    .init(levelName: "Tulang Pinggul Keluarga", imageName: "Unknown", pointsToUnlock: 64000, noLevel: 7),
    .init(levelName: "Korban GERD", imageName: "Unknown", pointsToUnlock: 128000, noLevel: 8)
]

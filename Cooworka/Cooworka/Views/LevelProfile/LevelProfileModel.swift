////
////  Level.swift
////  Cooworka
////
////  Created by Lucinda Artahni on 24/06/24.
////
//
import Foundation

struct LevelProfileModel {
    var imageName: String
    var pointsToUnlock: Int
    var noLevel: Int
}

var Levels: [LevelProfileModel] = [
    .init(imageName: "BudakJompo", pointsToUnlock: 1000, noLevel: 1),
    .init(imageName: "Unknown", pointsToUnlock: 2000, noLevel: 2),
    .init(imageName: "Unknown", pointsToUnlock: 4000, noLevel: 3),
    .init(imageName: "Unknown", pointsToUnlock: 8000, noLevel: 4),
    .init(imageName: "Unknown", pointsToUnlock: 16000, noLevel: 5),
    .init(imageName: "Unknown", pointsToUnlock: 32000, noLevel: 6),
    .init(imageName: "Unknown", pointsToUnlock: 64000, noLevel: 7),
    .init(imageName: "Unknown", pointsToUnlock: 128000, noLevel: 8),
    .init(imageName: "Unknown", pointsToUnlock: 256000, noLevel: 9)
         
]

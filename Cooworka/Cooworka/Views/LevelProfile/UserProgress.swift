//
//  UserProgress.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 26/06/24.
//

import SwiftUI

class UserProgress: ObservableObject {
    static let shared = UserProgress()
    @Published var xp: Int = 200
     init() {}
}

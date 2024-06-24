//
//  FormatFloatHelper.swift
//  Cooworka
//
//  Created by Natasha Hartanti Winata on 24/06/24.
//

import Foundation
import SwiftUI

public func formatFloat(_ rating: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale(identifier: "en_US")
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 1
    numberFormatter.minimumFractionDigits = 1
    return numberFormatter.string(from: NSNumber(value: rating)) ?? "\(rating)"
}

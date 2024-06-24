//
//  WiFiRatingComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct WiFiRatingComponent: View {
    let labels: [String] = ["CuihLemah", "LemahAbis", "SoSo", "OkAja", "OkBanget"]
    let imageBlues: [String] = ["CuihLemahBiru", "LemahAbisBiru", "SoSoBiru", "OkAjaBiru", "OkBangetBiru"]
    @Binding var selectedLabel: String?
    @State private var hasChanged: Bool = false
    let onFirstTap: () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Text("Kondisi Wifi")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .padding(.bottom, -2)
                
                Spacer()
            }
            HStack(spacing: 2) {
                ForEach(Array(zip(labels, imageBlues)), id: \.0) { label, imageBlue in
                    WiFiElement(label: label, isSelected: selectedLabel == label, imageBlue: imageBlue) {
                        handleSelection(label)
                    }
                }
            }
            
        }
        .padding(.top, 2)
        .padding(.bottom, -10)
        
    }
    
    private func handleSelection(_ label: String) {
        if selectedLabel != label {
            selectedLabel = label
            print("Selected label: \(label)")
            
            if !hasChanged {
                onFirstTap()
                hasChanged = true
            }
        }
    }
    
}

#Preview {
    WiFiRatingComponent(selectedLabel: .constant("CuihLemah"), onFirstTap: {})
}

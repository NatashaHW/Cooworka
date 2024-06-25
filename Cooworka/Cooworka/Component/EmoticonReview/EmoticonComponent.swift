//
//  EmoticonComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct EmoticonComponent: View {
    let labels: [String] = ["Gak nyaman", "Kureng", "So-so lah", "Pewee", "Super pewe"]
    let emoticonBlue: [String] = ["GakNyamanBiru", "KurengBiru", "So-so lah Biru", "PeweeBiru", "Super Pewe Biru"]
    @Binding var selectedLabel: String?
    @State private var hasChanged: Bool = false
    let onFirstTap: () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Text("Kenyamanan kursi dan meja")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .padding(.bottom, -2)
                
                Spacer()
            }
            HStack(spacing: 2) {
                ForEach(Array(zip(labels, emoticonBlue)), id: \.0) { label, emoticonBlue in
                    EmotNText(label: label, emoticonBlue: emoticonBlue, isSelected: selectedLabel == label, action: {
                        handleSelection(label)
                    })
                }
            }
            
        }
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
    EmoticonComponent(selectedLabel: .constant("Kureng"), onFirstTap: {})
}

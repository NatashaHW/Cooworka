//
//  EmoticonComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct EmoticonComponent: View {
    let labels: [String] = ["Gak nyaman", "Kureng", "So-so lah", "Pewee", "Super pewe"]
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
                ForEach(labels, id: \.self) { label in
                    EmotNText(label: label, isSelected: selectedLabel == label) {
                        handleSelection(label)
                    }
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

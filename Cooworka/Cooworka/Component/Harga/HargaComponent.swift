//
//  HargaComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct HargaComponent: View {
    let labels: [String] = ["< 50k", "50k - 100k", "100k - 150k", "150k - 200k", "> 200k"]
    @Binding var selectedLabel: String?
    @State private var hasChanged: Bool = false
    let onFirstTap: () -> Void
    
    var body: some View {
        VStack{
            HStack{
                Text("Harga")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .padding(.bottom, 5)
                
                Spacer()
            }
            HStack(spacing: 2) {
                ForEach(labels, id: \.self) { label in
                    HargaElement(label: label, isSelected: selectedLabel == label){
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
    HargaComponent(selectedLabel: .constant("Gak nyaman"), onFirstTap: {})
}

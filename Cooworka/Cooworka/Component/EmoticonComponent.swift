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
    
    var body: some View {
        VStack{
            HStack{
                Text("Kenyamanan kursi dan meja")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .padding(.bottom, 5)
                
                Spacer()
            }
            HStack(spacing: 5) {
                ForEach(labels, id: \.self) { label in
                    EmotNText(label: label, isSelected: selectedLabel == label) {
                        handleSelection(label)
                    }
                }
            }

        }
    }
    //MASIH BISA DIPENCET KALO UDAH DI SELECT!!
    private func handleSelection(_ label: String) {
            if selectedLabel == label {
                selectedLabel = nil
            } else {
                selectedLabel = label
                
                print("Selected label: \(label)")
            }
        }
}

#Preview {
    EmoticonComponent(selectedLabel: .constant("Kureng"))
}

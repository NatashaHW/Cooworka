//
//  KetersediaanParkirElement.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 21/06/24.
//

import SwiftUI

struct KetersediaanParkirElement: View {
    var label: String
    @Binding var isSelected: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isSelected ? Color.selected : Color.clear)
                .frame(width: 96, height: 41)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(isSelected ? Color.primaryBase : Color.unselected, lineWidth: 2)
                )
                .cornerRadius(7)
            
            
            Text(label)
                .font(.caption)
                .foregroundColor(.black)
                .background(Color.clear)
        }
        .onTapGesture {
            
            isSelected.toggle()
          

        }
        .padding(.horizontal, 2)
    }
}

#Preview {
    KetersediaanParkirElement(label: "haha", isSelected: .constant(true))
}

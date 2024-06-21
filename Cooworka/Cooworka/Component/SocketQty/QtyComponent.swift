//
//  QtyComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct QtyComponent: View {
    var label: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isSelected ? Color.selected : Color.clear)
                .frame(width: 60, height: 41)
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
            action()
        }
    }
}

#Preview {
    QtyComponent(label: "hahaha", isSelected: true, action: {})
}

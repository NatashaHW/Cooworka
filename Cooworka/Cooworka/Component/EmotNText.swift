//
//  EmotNText.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct EmotNText: View {
    var label: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isSelected ? Color.selected : Color.clear)
                .frame(width: 70, height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(isSelected ? Color.primaryBase : Color.clear, lineWidth: 2)
                )
                .cornerRadius(7)
            
            VStack{
                Image("\(label)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                
                
                Text(label)
                    .font(.caption2)
                    .foregroundColor(.black)
                    .background(Color.clear)
            }
        }
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    EmotNText(label: "Gak nyaman", isSelected: true, action: {})
}

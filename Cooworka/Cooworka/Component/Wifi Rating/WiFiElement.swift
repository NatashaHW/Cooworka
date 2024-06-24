//
//  WiFiElement.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct WiFiElement: View {
    var label: String
    var isSelected: Bool
    var imageBlue: String
    var action: () -> Void
    

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isSelected ? Color.selected : Color.clear)
                .frame(width: 68, height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(isSelected ? Color.primaryBase : Color.clear, lineWidth: 2)
                )
                .cornerRadius(7)
            
            VStack (spacing: 5){
                Image(isSelected ? imageBlue : label)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                   
                    
                    
                
                
                Text(label)
                    .font(.system(size: 10))
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
    WiFiElement(label: "CuihLemah", isSelected: true, imageBlue: "OkBanget", action: {})
}

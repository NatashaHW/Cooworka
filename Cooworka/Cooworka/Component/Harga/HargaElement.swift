//
//  hargaElement.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct HargaElement: View {
    var label: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(isSelected ? Color.selected : Color.clear)
                .frame(width: 68, height: 70)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(isSelected ? Color.primaryBase : Color.clear, lineWidth: 2)
                )
                .cornerRadius(7)
            
            VStack (spacing: 5){
                Image(isSelected ? "CoinSelected" : "OkBanget")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 29)
                   
                    
                
                Text(label)
                    .font(.system(size: 9))
                    .foregroundColor(.black)
                    .background(Color.clear)
            }
        }
//        .padding(.horizontal, 5)
        .onTapGesture {
            
            action()
            
  
        }
    }
}

#Preview {
    HargaElement(label: "150k - 200k", isSelected: true, action: {})
}

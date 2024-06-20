//
//  StarRatingComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct StarRatingComponent: View {
    var filled: Bool
    var label: String = ""
    
    var body: some View {
        VStack{
            Image(systemName: filled ? "star.fill" : "star")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .foregroundColor(filled ? Color("Primary") : Color("Primary"))
                .padding(.horizontal, 15)
            
            Text(label)
                .font(.caption2)
                .foregroundColor(.black)
                .padding(.top, 3)
            
            
        }
    }
}

#Preview {
    StarRatingComponent(filled: false, label: "So-so aja")
}

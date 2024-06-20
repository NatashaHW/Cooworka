//
//  Rating.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct Rating: View {
    @Binding var rating: Int
    var text: String
    var labels: [String]
    
    var body: some View {
        VStack{
            HStack{
                Text(text)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.bottom, 5)
                    

                Spacer()
            }
            
            HStack {
                ForEach(1..<6) { index in
                    StarRatingComponent(filled: index <= rating, label: labels[index-1])
                        .onTapGesture {
                            rating = index
                        }
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 16)
       
    }
}

#Preview {
    Rating(rating: .constant(3), text: "Suasana", labels: ["Kaya pasar", "Rame", "So-so lah", "Hening", "Mode Fokus"])
}

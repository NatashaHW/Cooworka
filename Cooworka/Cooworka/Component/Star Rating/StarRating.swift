//
//  Rating.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct StarRating: View {
    @Binding var rating: Int
    var text: String
    var labels: [String]
    let onRatingChange: () -> Void
    
    
    var body: some View {
        VStack{
            HStack{
                Text(text)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .padding(.bottom, 5)
                    

                Spacer()
            }
            
            HStack {
                ForEach(1..<6) { index in
                    StarRatingComponent(filled: index <= rating, label: labels[index-1])
                        .onTapGesture {
                            if rating == 0{
                                onRatingChange()
                            }
                            rating = index

                        }
                }
            }
        }

        .padding(.bottom, 16)
       
    }
}

#Preview {
    StarRating(rating: .constant(3), text: "Suasana", labels: ["Kaya pasar", "Rame", "So-so lah", "Hening", "Mode Fokus"]){
        
    }
}

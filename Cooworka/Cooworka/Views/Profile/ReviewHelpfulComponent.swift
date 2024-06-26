//
//  ReviewHelpfulComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct ReviewHelpfulComponent: View {
    @State var label: String
    var body: some View {
        HStack(spacing: 15){
            Image(label)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 37, height: 37)
            
            VStack{
                Text("1") //TODO: count of review
                    .font(.title3)
                    .fontWeight(.medium)
                
                Text(label)
                    .font(.body)
                    .foregroundColor(.gray) //TODO: sesuaiin color

            }

        }
    }
}

#Preview {
    ReviewHelpfulComponent(label: "IconReview")
}

//
//  LineProgressReview.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 19/06/24.
//

import SwiftUI

struct LineProgressReview: View {
    var body: some View {
        HStack{
            
            Rectangle()
                .frame(width: 101, height: 4)
                .cornerRadius(6)
                .foregroundColor(Color("GreyProgressBar"))
                .opacity(0.70)
        }
    }
}

#Preview {
    LineProgressReview()
}

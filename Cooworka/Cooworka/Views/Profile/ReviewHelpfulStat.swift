//
//  ReviewHelpfulStat.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct ReviewHelpfulStat: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 355, height: 75)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 5)
            
            HStack (spacing: 50){
                ReviewHelpfulComponent(label: "Review")
                
                ReviewHelpfulComponent(label: "Helpful")
            }
            
            
            
        }
        
    }
}

#Preview {
    ReviewHelpfulStat()
}

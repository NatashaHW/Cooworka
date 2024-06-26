//
//  ReviewPage1.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 19/06/24.
//

import SwiftUI

struct ReviewPageInitial: View {
    let cafe: ListCafe
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 110)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                    
                    NavigationLink(destination: ReviewPage1(cafe: cafe)) {
                        Text("Go to Detail View")
                            .padding(.horizontal, 100)
                            .padding(.vertical, 18)
                            .foregroundColor(.white)
                            .background(Color("Primary"))
                            .cornerRadius(15)
                        
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    
                    
                }
                
                
            }
            .ignoresSafeArea()
            
        }
        
    }
}

#Preview {
    ReviewPageInitial(cafe: exampleCafe)
}

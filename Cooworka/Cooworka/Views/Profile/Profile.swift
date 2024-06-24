//
//  Profile.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                
                Rectangle()
                    .frame(width: .infinity, height: 320)
                    .foregroundColor(.gray)
                
                
                Rectangle()
                    .frame(width: .infinity, height: 220)
                    .foregroundColor(.lightBlueForPopUp)
                    .cornerRadius(16)
                    
                
                VStack(spacing: 30){ //TODO: tanyain ini jadi gada badges??
                    PhotoProfileComponent()
                    
                    ReviewHelpfulStat()
                    
                    HStack(spacing: 100){
                        Text("Reviews")
                            .font(.title3)
                            .fontWeight(.medium)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .frame(height: 2)
                                        .foregroundColor(.black)
                                        .offset(y: 14)
                                )
                        
                        Text("Badges")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.white) //TODO: SESUAIIN WARNA
                            
                            
                        
                        
                    }
                    .padding(.top, -6)
                    
                }
                .padding(.top, 77)
                
                
            }
            
            ScrollView{ //TODO: ganti sama component review
                Rectangle()
                    .frame(width: 370, height: 200)
                
                Rectangle()
                    .frame(width: 370, height: 200)
                
                Rectangle()
                    .frame(width: 370, height: 200)
                
                Rectangle()
                    .frame(width: 370, height: 200)
                
            }
            
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    Profile()
}

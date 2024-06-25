//
//  PhotoProfileComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct PhotoProfileComponent: View {
    var body: some View {
        HStack(spacing: 15){
            Image("PhotoProfile")
                .resizable()
                .frame(width: 75, height: 75)
                .aspectRatio(contentMode: .fit
                )
            
            VStack (alignment: .leading, spacing: 7){
                Text("Natasha") //TODO: sesuaiin warnanya
                    .font(.title2)
                    .fontWeight(.medium)
                
                HStack{
                    Text("Budak Jompo") //TODO: sesuaiin warnanya
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                    
                    Spacer()
                        .frame(width: 18)
                    
                    Text("20 XP lagi naik pangkat") //TODO: sesuaiin warnanya
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 5)
                        .padding(.leading, 3)
                    
                }
                
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 250, height: 15)
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width: 890/1000*250, height: 9) //TODO: kalo mau dynamic, 890 ikutin XP, 1000 ikutin req next lvl
                        .foregroundColor(.clear) //TODO: ganti warna jadi gradient
                        .background(LinearGradient(gradient: Gradient(colors: [.lightYellow, .darkYellow]), startPoint: .leading, endPoint: .trailing))
                        .padding(3)
                    
                    
                }
            }
        }
        
        
       
    }
}

#Preview {
    PhotoProfileComponent()
}

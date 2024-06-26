//
//  PhotoProfileComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct PhotoProfileComponent: View {
    @ObservedObject var userProgress = UserProgress.shared
    
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
                    
                    Text("\(1000-userProgress.xp) XP lagi naik pangkat") //TODO: sesuaiin warnanya
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
                        .frame(width: CGFloat(userProgress.xp)/1000*250, height: 9) //TODO: kalo mau dynamic, 890 ikutin XP, 1000 ikutin req next lvl
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [.lightYellow, .darkYellow]), startPoint: .leading, endPoint: .trailing))
                        .mask(RoundedRectangle(cornerRadius: 25.0)
                            .frame(width: CGFloat(userProgress.xp)/1000*250, height: 9))
                        .padding(3)
                    
                    
                }
            }
        }
        
        
       
    }
}

#Preview {
    PhotoProfileComponent()
}

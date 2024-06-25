//
//  LevelView.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct LevelView: View {
    @State var descPangkat = "Pangkat kamu saat ini adalah..."
    @State var label = "Budak Jompo"
    
    var body: some View {
        VStack{
            ZStack{
                Rectangle()
                    .frame(width: .infinity, height: .infinity)
                    .foregroundColor(.backgroundProfile)
                
                Circle()
                    .scale(2)
                    .offset(y: 425)
                    .foregroundColor(.lightBlueForPopUp)
                
                
                VStack {
                    Spacer()
                        .frame(height: 75)
                    
                    Text(descPangkat)
                        .font(.headline)
                        .fontWeight(.regular)
                        .padding(.bottom, 5)
                    
                    Text(label)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 112, height: 52)
                            .foregroundColor(.white)
                            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 5)
                        
                        Text("890 XP") //TODO: ganti xp dari data
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                    }
                    .padding(.bottom, 24)
                    
//                    Image("BudakJompo")
//                        .resizable()
//                        .frame(width: 265, height: 265)
//                        .aspectRatio(contentMode: .fit)
                    
                    Circle()
                        .frame(width: .infinity, height: 330)
                    
                    Text("Kumpulkan 110 XP lagi untuk naik pangkat!")
                        .font(.subheadline)
                        .fontWeight(.regular)
//                        .padding(.top, 15)
                   
                    Text("Kunjungi cafe dan tulis review sekarang.")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .padding(.bottom, 20)
                    //TODO: cari cara buat hyperlink tulisan sekarang
                    
                    ReviewHelpfulStat()
                    
                    VStack(spacing: 5){ //TODO: animation transition scroll down ke page selanjutnya
                        Text("Scroll")
                            .fontWeight(.regular)
                            .font(.caption)
                        
                        
                        Image(systemName: "chevron.down")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22)
                    }
                    .padding(.top, 10)
                    
                    
                    
                        
                    
                    
                    Spacer()
                    
                }
//                .padding()
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
        }
    }
}

#Preview {
    LevelView()
}

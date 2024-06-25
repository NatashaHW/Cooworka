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
    
    @State var currentLevel = 1
    
    let levels: [LevelProfileModel]
    
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
                    
                    ZStack{
                        HStack(spacing: 150){
                            Button(action: {
                                if currentLevel != 1 {
                                    currentLevel -= 1
                                }
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .resizable()
                                    .frame(width: 8, height: 13)
                                    .foregroundColor(.black)
                            })
                            
                            Button(action: {
                                if currentLevel != 9 {
                                    currentLevel += 1
                                }
                            }, label: {
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .frame(width: 8, height: 13)
                                    .foregroundColor(.black)
                            })
                            
                            
                        }
                        .zIndex(1)
                        .offset(y: 100)
                        
                        ScrollViewReader { proxy in
                            ScrollView(.horizontal){
                                VStack (alignment: .leading){
                                    HStack(spacing: 75) {
                                        ForEach(levels, id: \.noLevel) { level in
                                            Image(level.imageName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 175)
                                                .scaleEffect(currentLevel == level.noLevel ? 1.1 : 0.9)
                                            
                                        }
                                    }
                                    .padding(.leading, 110)
                                    .padding(.bottom, 20)
                                    .padding(.top, 20)
                                    
                                    
                                    
                                    
                                    ZStack (alignment: .leading){
                                        RoundedRectangle(cornerRadius: 25)
                                            .frame(width: 2070/170, height: 10) //bagi point xp
                                            .padding()
                                            .zIndex(0.5)
                                            .overlay(
                                                LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing))
                                            .mask(RoundedRectangle(cornerRadius: 25)
                                                .frame(width: 2070/170, height: 10))
                                        
                                        
                                        
                                        RoundedRectangle(cornerRadius: 25)
                                            .frame(width: 2070, height: 14)
                                            .padding(.horizontal, 15)
                                            .foregroundColor(.white)
                                        
                                        
                                        HStack(spacing: 205){
                                            ForEach(levels, id: \.noLevel){ level in
                                                ZStack {
                                                    Image("PointBorder")
                                                        .resizable()
                                                        .frame(width: 46, height: 46)
                                                    
                                                    
                                                    Text("\(level.pointsToUnlock) XP")
                                                        .multilineTextAlignment(.center)
                                                        .frame(width: 40)
                                                        .font(.system(size: 7, weight: .regular))
                                                        .offset(y: 2)
                                                }
                                                
                                            }
                                            
                                        }
                                        .padding(.leading, 178)
                                        .zIndex(1)
                                    }
                                }
                            }
                            .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                            .onChange(of: currentLevel) { newValue in
                                withAnimation {
                                    proxy.scrollTo(newValue, anchor: .center)
                                }
                            }
                        }
                    }
                    
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
    LevelView(levels: [LevelProfileModel(imageName: "BudakJompo", pointsToUnlock: 256000, noLevel: 1),
                       LevelProfileModel(imageName: "Unknown", pointsToUnlock: 512000, noLevel: 2),
                       LevelProfileModel(imageName: "Unknown", pointsToUnlock: 512000, noLevel: 3)
                       
                       
                      ])
}

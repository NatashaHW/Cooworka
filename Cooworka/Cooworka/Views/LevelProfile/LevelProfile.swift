//
//  LevelProfile.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 25/06/24.
//

import SwiftUI

extension AnyTransition {
    static var pushFromBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.move(edge: .bottom).combined(with: .opacity),
            removal: AnyTransition.move(edge: .top).combined(with: .opacity)
        )
    }
    
    static var pushFromTop: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.move(edge: .top).combined(with: .opacity),
            removal: AnyTransition.move(edge: .bottom).combined(with: .opacity)
        )
    }
}

struct LevelProfile: View { //TODO: animation belum smooth
    @State private var showProfile = false
    
    let reviews: [ReviewCafe]
    
    var body: some View {
        NavigationView{
            ZStack {
                if showProfile {
                    Profile {
                        withAnimation {
                            showProfile.toggle()
                        }
                    }
                    .transition(.pushFromBottom)
                } else {
                    LevelView {
                        withAnimation {
                            showProfile.toggle()
                        }
                    }
                    .transition(.pushFromTop)
                }
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 83)
                        .foregroundColor(.white)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    HStack(spacing: 83){
                        
                        NavigationLink(destination: PageExplore(reviews: exampleReviews)){
                            ZStack {
                                
                                VStack (spacing: 5){
                                    Image("Eksplor")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    
                                    Text("Eksplor")
                                        .font(.system(size: 13))
                                        .foregroundColor(.grey999)
                                        .background(Color.clear)
                                }
                                
                            }
                            
                        }
                        
                        NavigationLink {
                            AktivitasPageView()
                        } label: {
                            ZStack {
                                VStack (spacing: 5){
                                    Image("Aktivitas")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    
                                    Text("Aktivitas")
                                        .font(.system(size: 13))
                                        .foregroundColor(.grey999)
                                        .background(Color.clear)
                                }
                                
                            }
                        }
                        
                        
                        NavigationLink {
                            LevelProfile()
                        } label: {
                            ZStack {
                                VStack (spacing: 5){
                                    Image("ProfilBiru")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    
                                    Text("Profil")
                                        .font(.system(size: 13))
                                        .foregroundColor(.primaryBase)
                                        .background(Color.clear)
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                .offset(y: 371)
            }
            .animation(.easeInOut, value: showProfile)
            
            
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    LevelProfile(reviews: exampleReviews)
}

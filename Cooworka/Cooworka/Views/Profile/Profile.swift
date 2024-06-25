//
//  Profile.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct Profile: View {
    var action: () -> Void
    
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                
                Rectangle()
                    .frame(width: .infinity, height: 320)
                    .foregroundColor(.clear)
                
                
                Rectangle()
                    .frame(width: .infinity, height: 245)
                    .foregroundColor(.lightBlueForPopUp)
                    .cornerRadius(16)
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 80)
                        .foregroundColor(.lightBlueForPopUp)
                    
                    VStack{
                        Image(systemName: "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12)
                        
                        Text("Scroll to back")
                            .font(.system(size: 12))
                            
                    }
                    .offset(y: 25)
                    .foregroundColor(.grey500)
                        
                }
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            withAnimation {
                                if gesture.translation.height > 25 {
                                    
                                    print("Swiped down!")
                                    action()
                                }
                            }
                        }
                    )
                    
                
                VStack(spacing: 30){
                    
                    PhotoProfileComponent()
                    
                    ReviewHelpfulStat()
                    
                    HStack(spacing: 100){
                        Text("My Reviews")
                            .font(.title2)
                            .fontWeight(.semibold)

                       
                        Spacer()
                        
                    }
                    .padding(.leading, 24)
                    .padding(.top, -10)
                    
                }
                .padding(.top, 100)
                
                
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
    Profile(action: {})
}

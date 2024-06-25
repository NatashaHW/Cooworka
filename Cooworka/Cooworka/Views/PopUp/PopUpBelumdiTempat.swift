//
//  PopUpBelumdiTempat.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 25/06/24.
//

import SwiftUI

struct PopUpBelumdiTempat: View {
    @State private var isDismissed = false
    
    var body: some View {
        if !isDismissed {
            VStack{
                Spacer()
                
                ZStack{

                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 17)
                            .offset(x: 130, y: -137 )
                            .zIndex(1)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 300, height: 317)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                    
                    VStack{
                        Rectangle()
                            .cornerRadius(16)
                            .frame(width: 300, height: 100)
                            .foregroundColor(.lightBlueForPopUp)
                        
                        Rectangle()
                            .frame(width: 300, height: 212)
                            .foregroundColor(.lightBlueForPopUp)
                            .cornerRadius(46)
                            .padding(.top, -100)
                        
                    }
                    .padding(.top, -97)
                    
                    
                    VStack{
                        Image("Reward")
                            .resizable()
                            .frame(width: 243, height: 236)
                            .padding(.top, -35)
                        
                        Text("Belum di cafe, ya?")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Datangi cafe untuk klaim reward dan dapatkan kejutannya.")
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .padding(.top, -5)
                            .frame(width: 225)
                            .font(.system(size: 12, weight: .regular))
                            .padding(.bottom, 10)
                        
                        
                    }
                    .padding(.top, 20)

                }

                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.4))
            .edgesIgnoringSafeArea(.all)

        }

    }
}

#Preview {
    PopUpBelumdiTempat()
}

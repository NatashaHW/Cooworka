//
//  PopUpSmall.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct PopUpSmall: View {
    @State private var isDismissed = false
    @State private var scale: CGFloat = 1.0
    @State private var offsetY: CGFloat = 0
    @State private var offsetX: CGFloat = 0
    @State private var backgroundOpacity = 0.4
    @State private var opacity = 1.0
    
    var body: some View {
        if !isDismissed {
            VStack{
                Spacer()
                
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: 300, height: 405)
                        .shadow(radius: 10)
                        .foregroundColor(.white)
                    
                    VStack{
                        Rectangle()
                            .cornerRadius(16)
                            .frame(width: 300, height: 100)
                            .foregroundColor(.lightBlueForPopUp)
                        
                        Rectangle()
                            .frame(width: 300, height: 220)
                            .foregroundColor(.lightBlueForPopUp)
                            .cornerRadius(46)
                            .padding(.top, -100)
                        
                    }
                    .padding(.top, -197)
                    
                    
                    VStack{
                        Image("Reward")
                            .resizable()
                            .frame(width: 243, height: 236)
                            .padding(.top, -35)
                        
                        Text("Misteri Reward!")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Tulis review untuk buka misteri reward yang kamu dapatkan.")
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .padding(.top, -5)
                            .frame(width: 225)
                            .font(.system(size: 12, weight: .regular))
                            .padding(.bottom, 10)
                        
                        Button(action: {
                            // Action for review button
                        }) {
                            Text("Review Sekarang")
                                .padding()
                                .frame(width: 200, height: 45)
                                .background(.primaryBase)
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .cornerRadius(10)
                        }
                        
                        Button(action: { //TODO: sesuaiin sama letak navbar activity
                            //TODO: save ke activity
                            withAnimation(.spring(response: 0.5, dampingFraction: 2, blendDuration: 0.6)) {
                                scale = 0.1
                                offsetY = 360
                                offsetX = -55
                                backgroundOpacity = 0
                                opacity = 0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                
                                isDismissed = true
                                
                            }
                        }) {
                            Text("Nanti aja")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.blue)
                        }
                        .padding(.top, 2)
                        
                    }
                    
                    
                }
                .scaleEffect(scale)
                .offset(x: offsetX, y: offsetY)
                .opacity(opacity)
                
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(backgroundOpacity).edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    PopUpSmall()
}
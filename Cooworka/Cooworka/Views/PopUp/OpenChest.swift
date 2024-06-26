//
//  OpenChest.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct OpenChest: View {
    @State private var isChestOpen = false
    @State private var shouldShake = false
    
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
    @Binding var totalPoint: Int
    
    @State private var isAppear = false
    @State private var scale: CGFloat = 0.1
    @State private var offsetY: CGFloat = 40
    @State private var offsetX: CGFloat = 50
    @State private var opacity = 0.0
    
    let reviews: [ReviewCafe]
    let cafe: ListCafe
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("ChestBackground")
                    .resizable()
                    .frame(maxWidth: .infinity)
                
                VStack{
                    if !isChestOpen{
                        VStack {
                            
                            Image("ReviewSelesai") //TODO: minta jadiin asset
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250)
                                .padding(.bottom, 20)
                            
                            
                            
                            Text("Terima kasih telah meluangkan waktu untuk menulis review!")
                                .multilineTextAlignment(.center)
                                .lineLimit(nil)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: 250)
                                .padding(.top, -20)
                        }
                    } else{
                        Text("Yeay! Kamu dapat")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(y: -20)
                    }
                    
                    
                    if isChestOpen {
                        Image("ChestOpen")
                            .resizable()
                            .frame(width: 275, height: 250)
                            .padding(.vertical, 125)
                            .offset(y: 52)
                            .rotationEffect(.degrees(isChestOpen ? 360 : 0))
                            .animation(.easeInOut(duration: 0.5))
                    } else {
                        Image("ChestLock")
                            .resizable()
                            .frame(width: 275, height: 250)
                            .padding(.vertical, 125)
                            .offset(y: shouldShake ? 24 : 25)
                            .rotationEffect(.degrees(shouldShake ? -5 : 0))
                            .animation(.easeInOut(duration: 0.1))
                            .onTapGesture {
                                withAnimation {
                                    shouldShake.toggle()
                                }
                                
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation {
                                        isChestOpen.toggle()
                                        self.feedbackGenerator.impactOccurred() //TODO: testing haptics
                                        shouldShake = false
                                    }
                                }
                                
                                
                                let shakeTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                    withAnimation {
                                        shouldShake.toggle()
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    shakeTimer.invalidate()
                                }
                            }
                    }
                    
                    if !isChestOpen{
                        Text("Tap untuk buka")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.white)
                            .offset(y: 55)
                    } else{
                        
                        NavigationLink(destination: LevelProfile(reviews: reviews, cafe: cafe), label: {Text("Klaim Reward")
                                .padding()
                                .frame(width: 342, height: 52)
                                .background(.buttonClaimChest)
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                            .cornerRadius(15)})//TODO: masukin ke wardrobe
                        
                        .offset(y: 70)
                    }
                    
                    
                }
                
                if isChestOpen{
                    HStack {
                        ZStack{
                            Text("+\(totalPoint) XP")
                                .font(.subheadline)
                                .zIndex(1)
                                .foregroundColor(.buttonClaimChest)
                                .offset(y: 15)
                            
                            Image("RewardPointKuning")
                                .resizable()
                                .frame(width: 125, height: 75)
                        }
                        .scaleEffect(scale)
                        .offset(x: offsetX, y: offsetY)
                        .opacity(opacity)
                        
                        ZStack{
                            Text("Kacamata")
                                .font(.subheadline)
                                .zIndex(1)
                                .foregroundColor(.buttonClaimChest)
                                .offset(y: 15)
                            
                            Image("Kacamata")
                                .resizable()
                                .frame(width: 125, height: 65)
                                .padding(.top, 10)
                        }
                        .scaleEffect(scale)
                        .offset(x: -offsetX, y: offsetY)
                        .opacity(opacity)
                    }
                    .onAppear {
                        withAnimation(.spring(response: 1.5, dampingFraction: 1.5, blendDuration: 0.5)) {
                            scale = 1
                            offsetY = -170
                            offsetX = -3
                            opacity = 1
                        }
                    }
                }
                
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OpenChest(totalPoint: .constant(120), reviews: exampleReviews, cafe: exampleCafe )
}

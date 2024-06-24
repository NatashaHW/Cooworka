//
//  ReviewPage3.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 21/06/24.
//

import SwiftUI

struct ReviewPage3: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var reviewExtra: String = ""
    
    @Binding var totalPoint: Int
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment: .topLeading){
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .shadow(radius: 8)
                        .frame(width: .infinity, height: 235)
                    
                    VStack{
                        HStack{
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            })
                            
                            Spacer()
                                .frame(width: 12)
                            
                            Text("Tambah Review")
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                        .padding()
                        .padding(.leading, 10)
                        
                        Rectangle()
                            .frame(width: .infinity, height: 110)
                            .padding()
                            .padding(.top, -10)
                            .padding(.horizontal, 10)
                        
                        HStack{
                            Text("Kamu akan mendapatkan...")
                                .fontWeight(.semibold)
                            
                            
                            Spacer()
                            
                            Text("+\(totalPoint) Xp")
                                .fontWeight(.bold)
                                .foregroundStyle(Color("PrimaryBase"))
                            
                        }
                        .padding(.horizontal, 27)
                        
                    }
                }
                
                HStack{
                    LineProgressReview()
                    LineProgressReview(color: "GreyProgressBarSelected")
                    LineProgressReview()
                }
                .padding(.horizontal, 24)
                
                VStack(spacing: 28){
                    FotoElement()
                    
                    
                    ReviewExtra(reviewText: $reviewExtra){
                        updateTotalPointsForReviewExtra()
                    } deductPoint: {
                        deductTotalPointsForReviewExtra()
                    }
  
                }
                
                
                Spacer()
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 110)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                    
                    NavigationLink(destination: ReviewPage3(totalPoint: $totalPoint)) {
                        Text("Go to Detail View")
                            .padding(.horizontal, 100)
                            .padding(.vertical, 18)
                            .foregroundColor(.white)
                            .background(Color("PrimaryBase"))
                            .cornerRadius(15)
                        
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
        }
    }
    
    private func updateTotalPointsForReviewExtra() {
        totalPoint += 10
    }
    
    private func deductTotalPointsForReviewExtra() {
        totalPoint -= 10
    }
}

#Preview {
    ReviewPage3(totalPoint: .constant(25))
}

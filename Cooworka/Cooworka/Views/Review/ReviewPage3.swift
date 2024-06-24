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
    @State var value: CGFloat = 0
    
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
                .padding(.bottom, 12)
                
                ScrollView{
                    VStack(spacing: 28){
                        FotoElement()
                        
                        
                        ReviewExtra(reviewText: $reviewExtra){
                            updateTotalPointsForReviewExtra()
                        } deductPoint: {
                            deductTotalPointsForReviewExtra()
                        }
                        
                    }
                    .offset(y: -self.value)
                    .animation(.spring())
                    .onAppear{
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main){ (noti) in
                            let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                            let height = value.height
                            
                            self.value = height - 175
                        }
                        
                        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main){ (noti) in
                            
                            self.value = 0
                        }
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
        .navigationBarBackButtonHidden(true)
    }
    
    private func updateTotalPointsForReviewExtra() {
        totalPoint += 50
    }
    
    private func deductTotalPointsForReviewExtra() {
        totalPoint -= 50
    }
}

#Preview {
    ReviewPage3(totalPoint: .constant(25))
}

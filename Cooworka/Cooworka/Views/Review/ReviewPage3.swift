//
//  ReviewPage3.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 21/06/24.
//

import SwiftUI

struct ReviewPage3: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var selectedImages: [UIImage] = []
    @State private var reviewExtra: String = ""
    
    
    @State var value: CGFloat = 0
    @State private var isPickerPresented: Bool = false
    
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
                                Image(systemName: "arrow.backward")
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

                        FotoElement(openGallery: {
                            isPickerPresented.toggle()
                        }, updatePoint: {
                            updateTotalPointsForAddPhoto()
                        })
                        .sheet(isPresented: $isPickerPresented) {
                            PhotoPicker(selectedImages: $selectedImages)
                                .edgesIgnoringSafeArea(.bottom)
                        }
                        
                        
                        if !selectedImages.isEmpty{
                            VStack{
                                ZStack{
                                    HStack{
                                        Spacer()
                                            .frame(width: 315)
                                        Button(action: {
                                            selectedImages.removeAll()
                                            deductTotalPointsForAddPhoto()
                                            
                                        }, label: {
                                            Image(systemName: "x.circle")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.gray)
                                            
                                        })
                                    }
                                    .zIndex(1)
                                    .offset(y: -43)
                                    .padding(.top, -7)
                                    
                                    Rectangle()
                                        .frame(width: 344, height: 120)
                                        .cornerRadius(16)
                                        .foregroundColor(.photoBackground)
                                    
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(selectedImages, id: \.self) { image in
                                                Image(uiImage: image)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(height: 80)
                                                
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                        .padding(.top, 15)
                                    }
                                    .frame(width: 330, height: 95)
                                }
                                .padding(.top, -18)
                            }
                            
                        }
                        
                        
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
                            
                            self.value = height - 190
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
                    
                    NavigationLink(destination: ReviewPage3(totalPoint: $totalPoint)) { //TODO: save ke cloudkit
                        Text("Buka Reward")
                            .padding(.horizontal, 120)
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
    
    private func updateTotalPointsForAddPhoto(){
        totalPoint += 30
    }
    
    private func deductTotalPointsForAddPhoto(){
        totalPoint -= 30
    }
    
}

#Preview {
    ReviewPage3(totalPoint: .constant(25))
}

//
//  ReviewPage2.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct ReviewPage2: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedSocketQty: Int = -1
    @State  var kenyamananKursiDanMeja: String?
    
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
                
                VStack{
                    HStack{
                        Text("WFC Suporter")
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                    }
                    
                    Rectangle()
                        .frame(width: .infinity, height: 85)
                    
                    
                    SocketQty() { selectedIndex in
                        selectedSocketQty = selectedIndex
                        
                    } onFirstTap: {
                        updateTotalPoints()
                    }
                    
                    EmoticonComponent(selectedLabel: $kenyamananKursiDanMeja)

                    
                    
                    
                    
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 110)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                    
                    NavigationLink(destination: ReviewPage2( totalPoint: $totalPoint)) {
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
    
    private func updateTotalPoints() {
        totalPoint += 10
        }
}

#Preview {
    ReviewPage2(totalPoint: .constant(15))
}

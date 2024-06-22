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
    @State private var adaRuangMeeting: Bool = false
    @State private var adaRuangBerdoa: Bool = false
    @State private var adaAreaMerokok: Bool = false
    @State private var adaParkirMotor: Bool = false
    @State private var adaParkirMobil: Bool = false
    
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
                
                ScrollView{
                    VStack{
                        HStack{
                            Text("WFC Suporter")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                        }
                        
                        Rectangle()
                            .frame(width: .infinity, height: 73)
                        
                        
                        SocketQty() { selectedIndex in
                            selectedSocketQty = selectedIndex
                            
                        } onFirstTap: {
                            updateTotalPoints()
                        }
                        
                        EmoticonComponent(selectedLabel: $kenyamananKursiDanMeja){
                            updateTotalPoints()
                        }
                        
                        HStack{
                            Text("Kelengkapan")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.top, 1)
                        .padding(.bottom, -2)
                        
                        PreviewYesNoButton(ada: $adaRuangMeeting, title: "Ruang Meeting"){
                            updateTotalPoints()
                        }
                        
                        PreviewYesNoButton(ada: $adaRuangBerdoa, title: "Ruangan Berdoa"){
                            updateTotalPoints()
                        }
                        
                        PreviewYesNoButton(ada: $adaAreaMerokok, title: "Area Merokok"){
                            updateTotalPoints()
                        }
                        
                        KetersediaanParkir(isMotorParking: $adaParkirMotor, isMobilParking: $adaParkirMobil, title: "Area Parkir"){
                            updateTotalPoints()
                        }
                        

                        
                    }
                    
                }
                .padding(.horizontal, 24)
                
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
    
    private func updateTotalPoints() {
        totalPoint += 10
    }
}

#Preview {
    ReviewPage2(totalPoint: .constant(15))
}

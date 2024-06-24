//
//  ReviewPage1.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 19/06/24.
//

import SwiftUI

struct ReviewPage1: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var ratingSuasana: Int = 0
    @State private var ratingPelayanan: Int = 0
    @State private var ratingRasa: Int = 0
    @State var rangeHarga: String?
    
    @State private var adaMakananBerat: Bool = false
    
    @State private var totalPoint = 0
    
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
                    LineProgressReview(color: "GreyProgressBarSelected")
                    LineProgressReview()
                    LineProgressReview()
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 12)
                
                ScrollView{
                    VStack{
                        StarRating(rating: $ratingSuasana, text: "Suasana", labels: ["Kaya pasar", "Rame", "So-so lah", "Hening", "Mode Fokus"]){
                            updateTotalPoints()
                        }
                        
                        StarRating(rating: $ratingPelayanan, text: "Pelayanan", labels: ["Perbaiki ya..", "Kureng", "So-so lah", "Top Abis", "Berasa Raja"]){
                            updateTotalPoints()
                        }
                        
                        StarRating(rating: $ratingRasa, text: "Rasa", labels: ["Not taste", "Hmm..", "So-so lah", "Boleh Juga", "Enak Bingit"]){
                            updateTotalPoints()
                        }
                        
                        HargaComponent(selectedLabel: $rangeHarga){
                            updateTotalPoints()
                        }
                        
                        
                        PreviewYesNoButton(ada: $adaMakananBerat, title: "Makanan berat"){
                            updateTotalPoints()
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 24)
                }
                
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
    }
    
    private func updateTotalPoints() {
        totalPoint += 10
        }

}

#Preview {
    ReviewPage1()
}

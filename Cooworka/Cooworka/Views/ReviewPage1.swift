//
//  ReviewPage1.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 19/06/24.
//

import SwiftUI

struct ReviewPage1: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment: .topLeading){
                    Rectangle()
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .shadow(radius: 10)
                        .frame(width: .infinity, height: 270)
                    
                    
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
                            .frame(width: .infinity, height: 130)
                            .padding()
                            .padding(.top, -10)
                            .padding(.horizontal, 10)
                        
                        HStack{
                            Text("Kamu akan mendapatkan...")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("+0 Xp")
                                .fontWeight(.bold)
                                .foregroundStyle(Color("Primary"))
                            
                            
                        }
                        .padding(.horizontal, 27)
                        
                        
                        
                        
                    }
                    
                    
                }
                
                VStack{
                    Text("Hello")
                    
                    Text("Hello")
                }
                Spacer()
                
                
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 110)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                    
                    NavigationLink(destination: ReviewPage1()) {
                        Text("Go to Detail View")
                            .padding(.horizontal, 100)
                            .padding(.vertical, 18)
                            .foregroundColor(.white)
                            .background(Color("Primary"))
                            .cornerRadius(15)
                        
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            
            
        }
        
        
        
    }
}

#Preview {
    ReviewPage1()
}

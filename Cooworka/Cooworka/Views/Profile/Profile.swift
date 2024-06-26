//
//  Profile.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 24/06/24.
//

import SwiftUI

struct Profile: View {
    var action: () -> Void
    
//    let cafe: ListCafe
    let reviews: [ReviewCafe]
    
    var body: some View {
        VStack{
            ZStack(alignment: .top){
                
                Rectangle()
                    .frame(width: .infinity, height: 320)
                    .foregroundColor(.clear)
                
                
                Rectangle()
                    .frame(width: .infinity, height: 245)
                    .foregroundColor(.lightBlueForPopUp)
                    .cornerRadius(16)
                
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: 80)
                        .foregroundColor(.lightBlueForPopUp)
                    
                    VStack(spacing: 0){
                        Image(systemName: "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12)
                        
                        Image(systemName: "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12)
                            
                    }
                    .offset(y: 25)
                    .foregroundColor(.grey500)
                    .padding(.top, 28)
                        
                }
                .gesture(
                    DragGesture()
                        .onEnded { gesture in
                            withAnimation {
                                if gesture.translation.height > 25 {
                                    
                                    print("Swiped down!")
                                    action()
                                }
                            }
                        }
                    )
                    
                
                VStack(spacing: 30){
                    
                    PhotoProfileComponent()
                    
                    ReviewHelpfulStat()
                    
                    HStack(spacing: 100){
                        Text("My Reviews")
                            .font(.title2)
                            .fontWeight(.semibold)

                       
                        Spacer()
                        
                    }
                    .padding(.leading, 24)
                    .padding(.top, -10)
                    
                }
                .padding(.top, 100)
                
                
            }
            
            ScrollView{ //TODO: ganti sama component review
                ForEach(reviews.filter { $0.userName == "Natasha" }) { review in
                    ReviewCard(
                        userImage: review.userImage,
                        userName: review.userName,
                        userLevel: review.userLevel,
                        reviewCount: review.reviewCount,
                        reviewText: review.reviewText,
                        reviewDate: review.reviewDate,
                        rating: review.rating,
                        likeCount: review.likeCount
                    )
                }
                
            }
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    Profile(action: {}, reviews: exampleReviews)
}

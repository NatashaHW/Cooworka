import SwiftUI

struct ReviewCard: View {
    //TODO: ganti variabel variabel ini jadi sesuai database
    let userImage: String
    let userName: String
    let userLevel: String
    let reviewCount: Int
    let reviewText: String
    let reviewDate: String
    let rating: Double
    let likeCount: Int
    @State private var isLiked: Bool = false
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                Image(userImage)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 11) {
                        VStack(alignment: .leading, spacing: 2) {
                            //User Name
                            HStack {
                                Text(userName)
                                    .font(
                                        Font.custom("Nunito", size: 16)
                                            .weight(.semibold)
                                    )
                                Spacer()
                                
                                //Star Rating
                                HStack(spacing: 5) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color("Star"))
                                        .font(.system(size: 12))
                                    
                                    HStack(spacing: 3.5) {
                                        Text("\(formatFloat(rating))")
                                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                                            .foregroundColor(.black)
                                        
                                    }
                                }
                                .padding(8)
                                .background(Color("Grey50"))
                                .cornerRadius(16)
                            }
                            
                            // User Level
                            HStack(spacing: 2) {
                                Text(userLevel)
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                Text(" • \(reviewCount) Reviews")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 7) {
                            // Review text
                            Text(reviewText)
                                .lineLimit(isExpanded ? nil : 3)
                                .font(.system(size: 14))
                                .lineSpacing(3)
                            
                            if reviewText.count > 100 {
                                Button(action: {
                                    withAnimation {
                                        isExpanded.toggle()
                                    }
                                }) {
                                    Text(isExpanded ? "Show less" : "Show more")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("PrimaryBase"))
                                        .underline()
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 7) {
                        // Review photos
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(0..<4) { _ in
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.5))
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                }
                            }
                        }
                        
                        // Review Date
                        Text(reviewDate)
                            .font(.system(size: 13))
                            .foregroundColor(Color("GreyTertiary"))
                    }
                }
                .frame(maxWidth: 305)
            }
            
            HStack {
                Button(action: {
                    isLiked.toggle()
                }) {
                    HStack {
                        Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .foregroundColor(Color("PrimaryBase"))
                        //TODO: jumlah likenya disimpan ke database
                        Text("\(likeCount + (isLiked ? 1 : 0))")
                            .foregroundColor(Color("PrimaryBase"))
                    }
                    .font(.system(size: 16))
                }
                
                Spacer()
            }
            .padding(.leading, 50)
        }
        .padding()
    }
    
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        ReviewCard(
            userImage: "UserProfile", // Replace with actual image name
            userName: "Natasha",
            userLevel: "Budak Jompo",
            reviewCount: 3,
            reviewText: "Salah satu RM Padang favorit gw di Jakarta! Kali ini cobain di outlet BSD 😍😍 yuhu seperti biasa tempatnya luas & rame yaaa! Even rame pelayanannya",
            reviewDate: "24 Apr 2024",
            rating: 4.8,
            likeCount: 13
        )
        .previewLayout(.sizeThatFits)
    }
}

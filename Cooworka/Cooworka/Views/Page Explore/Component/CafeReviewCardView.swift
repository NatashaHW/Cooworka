
import SwiftUI

//TODO: Assume we have a Review model (ganti jadi data cloudkit hrsnya)
struct ReviewCafe: Identifiable {
    let id = UUID()
    let userImage: String
    let userName: String
    let userLevel: String
    let reviewCount: Int
    let reviewText: String
    let reviewDate: String
    let rating: Double
    let likeCount: Int
    let cafeName: String
}

struct CafeReviewCardView: View {
    let cafe: ListCafe
    let reviews: [ReviewCafe]  // TODO: Pass reviews to the view
    @State private var isExpanded = false
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            HStack {
                //                NavigationLink(){
                ZStack {
                    Rectangle()
                        .frame(width: 168, height: 38)
                        .foregroundColor(.clear)
                    
                    VStack(spacing: 3) {
                        Text("Reviews")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("PrimaryBase"))
                        Rectangle()
                            .frame(width: 80, height: 2)
                            .foregroundColor(Color("PrimaryBase"))
                            .cornerRadius(5)
                    }
                    
                }
                //                }
                
                //                NavigationLink(){
                ZStack {
                    Rectangle()
                        .frame(width: 168, height: 38)
                        .foregroundColor(.clear)
                    
                    Text("Photos")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("Grey500"))
                }
                //                }
            }
            //TODO: ganti jadi database
            if !(reviews.filter { $0.cafeName == cafe.name }).isEmpty {
                //TODO: ganti jadi database -> sekarang ini bandingin nama cafe nya yang sama -> bisa lu ganti sama bandingin UUID -> bebas yg mana, yang gampang dulu aja sher
                ForEach(reviews.filter { $0.cafeName == cafe.name }) { review in
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
            } else {
                HStack{
                    Spacer()
                    VStack(alignment: .center, spacing: -5) {
                        
                        Text("Pahlawan ulasan dibutuhkan !\nSiap jadi yang pertama ?")
                            .font(
                                Font.custom("Nunito", size: 20)
                                    .weight(.bold)
                            )
                            .frame(width: 280, height: 100, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        
                        Image("EmptyStateRiwayat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, alignment: .center)
                        
                        
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    
                    Spacer()
                }.padding(.top, -25)
            }
        }
    }
}


struct CafeReviewCard_Previews2: PreviewProvider {
    static var previews: some View {
        CafeReviewCardView(cafe: exampleCafe, reviews: exampleReviews)
    }
}

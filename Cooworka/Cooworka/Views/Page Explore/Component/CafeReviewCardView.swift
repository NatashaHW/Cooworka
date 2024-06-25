
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
        }
    }
}


struct CafeReviewCard_Previews2: PreviewProvider {
    static var previews: some View {
        CafeReviewCardView(cafe: exampleCafe, reviews: exampleReviews)
    }
}

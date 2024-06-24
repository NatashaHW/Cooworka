import SwiftUI
import MapKit

struct PageDetailView: View {
    let cafe: ListCafe
    let reviews: [ReviewCafe]  //TODO: Pass reviews to the view
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: -125) {
                Image("CafeImage")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 280)
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                
                ScrollView {
                    VStack(spacing: 20) {
                        InfoCardView(cafe: cafe)
                        
                        CafeReviewCardView(cafe: cafe, reviews: reviews)  // TODO: Pass reviews here
                    }
                }
                .background(
                    UnevenRoundedRectangle(
                    topLeadingRadius: 16,
                    bottomLeadingRadius: 0,
                    bottomTrailingRadius: 0,
                    topTrailingRadius: 16,
                    style: .continuous
                    ).fill(Color.white)
                )
                .padding(.bottom, 140)
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 120)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                    
                    Text("Klaim Hadiah")
                        .font(
                            Font.custom("Nunito", size: 24)
                                .weight(.bold)
                        )
                        .padding(.horizontal, 100)
                        .padding(.vertical, 18)
                        .foregroundColor(.white)
                        .background(Color("PrimaryBase"))
                        .cornerRadius(15)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

// Sample data for preview
let exampleCafe = ListCafe(
    name: "Red Foxed Cafe By Moritz INN BSD",
    address: "The Breeze, Jl. Grand Boulevard, BSD, Serpong, Tangerang Selatan",
    openHours: "09:00 - 22:00",
    distance: 2.5,
    taste: 4.0,
    ambience: 4.5,
    service: 4.7,
    rating: 0, totalRatings: 120,
    coordinate: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
)

let exampleReviews = [
    ReviewCafe(
        userImage: "UserProfile",
        userName: "Natasha",
        userLevel: "Budak Jompo",
        reviewCount: 3,
        reviewText: "Salah satu RM Padang favorit gw di Jakarta! Kali ini cobain di outlet BSD 😍😍 yuhu seperti biasa tempatnya luas & rame yaaa! Even rame pelayanannya",
        reviewDate: "24 Apr 2024",
        rating: 4.8,
        likeCount: 13,
        cafeName: "Red Foxed Cafe By Moritz INN BSD" //TODO: Notes, nama cafe di exampleReview dan nama cafe di exampleCafe harus sama, karna skrg ini logic nya nyari yang namanya sama -> bisa lu ganti jadi cari yang userID nya sama
    ),
    
    
    ReviewCafe(
        userImage: "UserProfile",
        userName: "Aileen",
        userLevel: "Budak Jompo",
        reviewCount: 4,
        reviewText: "Recommended banget buat tempat WFC 😍😍 wifinya kenceng, bagus, mejanya luas, banyak colokan",
        reviewDate: "26 Apr 2024",
        rating: 4.7,
        likeCount: 12,
        cafeName: "Red Foxed Cafe By Moritz INN BSD"
    ),
    
    // Add more Review instances as needed
]

struct PageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PageDetailView(cafe: exampleCafe, reviews: exampleReviews)
    }
}

struct PageReview_Previews2: PreviewProvider {
    static var previews: some View {
        PageReview(reviews: exampleReviews)
    }
}

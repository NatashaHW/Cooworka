import SwiftUI
import MapKit

struct PageDetailViewIsi: View {
    @Environment(\.presentationMode) var presentationMode
    
    let cafe: ListCafe
    let reviews: [ReviewCafe]  //TODO: Pass reviews to the view
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    @ObservedObject var searchNearby: SearchNearby
    
    @State private var showMysteryChestPopup = false
    @State private var showNotInCafePopup = false
    
   
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                if showMysteryChestPopup {
                    PopUpSmall()
                        .transition(.opacity)
                        .zIndex(1)
                }
                
                if showNotInCafePopup {
                    PopUpBelumdiTempat(isDismissed: $showNotInCafePopup)
                        .transition(.opacity)
                        .zIndex(1)
                }
                
                
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
                            
                            CafeReviewCardView(cafe: cafe, reviews: exampleReviewsIsi)  // TODO: Pass reviews here
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
                        
                        Button(action: {
                            // Action for claiming the reward
                            if let userLocation = searchNearby.userLocation {
                                let cafeLocation = CLLocation(latitude: cafe.coordinate.latitude, longitude: cafe.coordinate.longitude)
                                
                                if isNearbyUserLocation(userLocation: userLocation, cafeLocation: cafeLocation) {
                                    // Logic untuk menampilkan pop-up MysteryChest jika dekat dengan kafe
                                    // Misalnya: showMysteryChestPopup()
                                    
                                    showMysteryChestPopup = true
                                    showNotInCafePopup = false
                                    print("User is nearby the cafe")
                                } else {
                                    // Logic untuk menampilkan pop-up NotInCafe jika tidak dekat dengan kafe
                                    showMysteryChestPopup = false
                                    showNotInCafePopup = true
                                    // Misalnya: showNotInCafePopup()
                                    print("User is not nearby the cafe")
                                }
                            }
                        }) {
                            Text("Klaim Reward")
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
                }
                .edgesIgnoringSafeArea(.bottom)
                
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        )
                }
                .padding()
                .padding(.leading, 5)
                .padding(.top, -20)
                
                
                
            }
           
        }
        .navigationBarBackButtonHidden()
    }
    
    // Logic Check In: Toleransi 50 meter
    private func isNearbyUserLocation(userLocation: CLLocation, cafeLocation: CLLocation, maxDistance: CLLocationDistance = 50) -> Bool {
        let distance = userLocation.distance(from: cafeLocation)
        return distance <= maxDistance
    }
}

struct PageDetailViewIsi_Previews: PreviewProvider {
    static var previews: some View {
        PageDetailViewIsi(cafe: exampleCafe, reviews: exampleReviews, searchNearby: SearchNearby())
    }
}

struct PageExploreIsi_Previews2: PreviewProvider {
    static var previews: some View {
        //TODO: ganti jadi firstname user
        var firstName = "Natasha"
        PageExplore(reviews: exampleReviews, firstName: firstName)
    }
}

let exampleReviewsIsi = [
    ReviewCafe(
        userImage: "UserProfile",
        userName: "Natasha",
        userLevel: "Budak Jompo",
        reviewCount: 3,
        reviewText: "Salah satu tempat WFC favorit gw di BSD 😍 tempatnya luas & cozy banget! Even pelayanannya ramah 😍",
        reviewDate: "24 Apr 2024",
        rating: 4.8,
        likeCount: 13,
        cafeName: "NOB Cafe, The Breeze BSD" //TODO: Notes, nama cafe di exampleReview dan nama cafe di exampleCafe harus sama, karna skrg ini logic nya nyari yang namanya sama -> bisa lu ganti jadi cari yang userID nya sama
    ),
]

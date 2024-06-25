import SwiftUI
import MapKit

struct PageExplore: View {
    @State private var isLocationViewPresented = false
    @State private var selectedLocationName: String = "Your Location"
    @StateObject private var viewModel = SearchNearby()
    //TODO: ganti ke database
    let reviews: [ReviewCafe]
    var firstName: String?
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: -75) {
                ZStack(alignment: .topLeading) {
                    Image("Banner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: screenWidth, maxHeight: 260)
                        .edgesIgnoringSafeArea(.top)
                    
                    VStack(alignment: .leading, spacing: 18) {
                        HStack () {
                            // Select Location
                            Button(action: {
                                isLocationViewPresented = true
                            }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.system(size: 16))
                                    
                                    HStack(spacing: 14) {
                                        Text(selectedLocationName)
                                            .font(
                                                Font.custom("Nunito", size: 16)
                                                    .weight(.bold)
                                            )
                                        
                                        Image(systemName: "chevron.down")
                                            .font(.system(size: 16))
                                    }
                                }
                                .foregroundColor(.black)
                                .padding(8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color("Grey50"))
                                        
                                )
                                .frame(width: 200, alignment: .leading)
                                .multilineTextAlignment(.center)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .padding(.leading, 20)
                            }
                            .sheet(isPresented: $isLocationViewPresented) {
                                SelectLocationView { location in
                                    selectedLocationName = location.name
                                }
                            }
                            
                            Spacer()
                            
                            Image(systemName: "bell.badge.fill")
                                .foregroundStyle(.red, .white)
                                .font(.system(size: 20))
                                .padding(.trailing, 22)
                            
                        }
                        
                        //TODO: ubah jadi database
                        Text("Welcome \(firstName ?? "Natasha")!")
                            .font(
                                Font.custom("Nunito", size: 16)
                                    .weight(.bold)
                            )
                            .lineSpacing(3)
                            .frame(width: 120)
                            .frame(maxHeight: 60)
                            .padding(.leading, 225)
                            .lineLimit(2)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.center)
                    }
                }
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 40) {
                        VStack(spacing: 25) {
                            // SearchBar
                            NavigationLink(destination: SearchCafeView(reviews: reviews)) {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.white)
                                        .frame(width: 344, height: 40)
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.gray)
                                        Text("Search")
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    .padding(.leading, 40)
                                    .padding(.trailing, 12)
                                }
                            }
                            
                            VStack(spacing: 35) {
                                HStack(spacing: 20) {
                                    CategoryCafe(imageName: "Bintang4", title: "Bintang 4+", subtitle: "Hanya pilihan terbaik.")
                                    
                                    CategoryCafe(imageName: "Under50k", title: "Under 50k", subtitle: "Ada yang murah meriah!")
                                }
                                
                                HStack(spacing: 20) {
                                    CategoryCafe(imageName: "Tercozy", title: "Ter-cozy", subtitle: "Chill, berasa rumah sendiri.")
                                        
                                    
                                    CategoryCafe(imageName: "NgopiDulu", title: "Ngopi Dulu", subtitle: "Sruput sruput sedap.")
                                }
                            }
                        }
                        Text("Cafe di Sekitar Kamu")
                            .font(.system(size: 26, weight: .bold))
                            .padding(.leading, 20)
                    }
                    .frame(maxWidth: screenWidth)
                    
                    // List nearby cafe
                    ScrollView {
                        VStack (spacing: 15) {
                            ForEach(viewModel.cafes) { cafe in
                                NearbyCardView(cafe: cafe, reviews: reviews, searchNearby: viewModel)
                                    .padding(.top, 5)
                            }.frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.requestLocationPermission()
            }
        }
    }
    
    private func openInMaps(cafe: ListCafe) {
        let placemark = MKPlacemark(coordinate: cafe.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = cafe.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

struct PageExplore_Previews: PreviewProvider {
    static var previews: some View {
        //TODO: ganti jadi firstname user
        var firstName = "Natasha"
        PageExplore(reviews: exampleReviews, firstName: firstName)
    }
}


import SwiftUI

struct CategoryCafe: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 170, height: 80)
                .cornerRadius(16)
                .edgesIgnoringSafeArea(.top)
                .padding(.bottom, -20)
            
            VStack(alignment: .center, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                
                Text(subtitle)
                    .font(.system(size: 10))
                    .lineLimit(2)
                    .frame(width: 85, height: 30)
                    .padding(.leading, -5)
            }
            .padding(.top, 20)
            .padding(.horizontal, 8)
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryCafe(imageName: "Bintang4", title: "Bintang 4+", subtitle: "Hanya pilihan terbaik.")
            .previewLayout(.fixed(width: 200, height: 120))
            .padding()
    }
}

import SwiftUI
import MapKit

struct PageExplore: View {
    @State private var isLocationViewPresented = false
    @State private var selectedLocationName: String = "BSD"
    @StateObject private var viewModel = SearchNearby()
    let reviews: [ReviewCafe]
    
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
                    
                    HStack (spacing: screenWidth - 180) {
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
                            .padding(.leading, 20)
                        }
                        .sheet(isPresented: $isLocationViewPresented) {
                            SelectLocationView { location in
                                selectedLocationName = location.name
                            }
                        }
                        
                        
                        Image(systemName: "bell.badge.fill")
                            .foregroundStyle(.red, .white)
                            .font(.system(size: 20))
                        
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
                            
                            VStack(spacing: 30) {
                                HStack{
                                    Image("Above4Star")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 170, height: 80)
                                        .edgesIgnoringSafeArea(.top)
                                        .padding(.bottom, -20)
                                    
                                    Image("Under50k")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 170, height: 80)
                                        .edgesIgnoringSafeArea(.top)
                                        .padding(.bottom, -20)
                                }
                                
                                HStack{
                                    Image("GoodAmbience")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 170, height: 80)
                                        .edgesIgnoringSafeArea(.top)
                                        .padding(.bottom, -20)
                                    
                                    Image("GoodCoffee")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 170, height: 80)
                                        .edgesIgnoringSafeArea(.top)
                                        .padding(.bottom, -20)
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
                                NearbyCardView(cafe: cafe, reviews: reviews)
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
        PageExplore(reviews: exampleReviews)
    }
}

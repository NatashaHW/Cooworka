import SwiftUI
import MapKit

struct FavoritePageView: View {
    @StateObject private var viewModel = SearchNearby()
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Aktivitas")
                        .font(.system(size: 26, weight: .bold))
                    
                    HStack {
                        NavigationLink(destination: AktivitasPageView()){
                            ZStack {
                                Rectangle()
                                    .frame(width: 168, height: 38)
                                    .foregroundColor(.clear)
                                
                                Text("Riwayat")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color("Grey500"))
                                
                            }
                        }
                        
                        NavigationLink(destination: FavoritePageView()){
                            ZStack {
                                Rectangle()
                                    .frame(width: 168, height: 38)
                                    .foregroundColor(.clear)
                                
                                VStack(spacing: 3) {
                                    Text("Tempat Favorite")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(Color("PrimaryBase"))
                                    Rectangle()
                                        .frame(width: 140, height: 2)
                                        .foregroundColor(Color("PrimaryBase"))
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: screenWidth)
                
                ScrollView {
                    VStack (spacing: 20) {
                        
                        ForEach(viewModel.cafes) { cafe in
                            DetailCardView(cafe: cafe)
                                .onTapGesture {
                                    openInMaps(cafe: cafe)
                                }
                        }.frame(maxWidth: .infinity)
                    }
                }
            }
            
            .onAppear {
                viewModel.requestLocationPermission()
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func openInMaps(cafe: ListCafe) {
        let placemark = MKPlacemark(coordinate: cafe.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = cafe.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    FavoritePageView()
}


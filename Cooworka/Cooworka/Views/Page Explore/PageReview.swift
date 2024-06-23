import SwiftUI
import MapKit

struct PageReview: View {
    @State private var isLocationViewPresented = false
    @State private var selectedLocationName: String = "BSD"
    @StateObject private var viewModel = SearchNearby()

    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(maxWidth: screenWidth, maxHeight: 260)
                        .edgesIgnoringSafeArea(.top)

                    Button(action: {
                        isLocationViewPresented = true
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 16))

                            Text(selectedLocationName)
                                .font(
                                    Font.custom("Nunito", size: 16)
                                        .weight(.bold)
                                )
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
                }

                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        // SearchBar
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 344, height: 18)

                        Text("Cafe di Sekitar Kamu")
                            .font(.system(size: 26, weight: .bold))
                    }
                    .frame(maxWidth: screenWidth)

                    ScrollView {
                        VStack (spacing: 20) {
                            ForEach(viewModel.cafes) { cafe in
                                NearbyCardView(cafe: cafe)
                                    .onTapGesture {
                                        openInMaps(cafe: cafe)
                                    }
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

#Preview {
    PageReview()
}

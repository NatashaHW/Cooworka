//model data
import Foundation
import CoreLocation

//TODO: ini kan variabel cuman untuk search aja, tapi hubungin sama database bagian ratingnya, trus kalau di select baru save ke database cafe
struct SearchCafe: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    let rating: Double
    let totalRatings: Int
    let openHours: String
    let distance: Double
}


//search cafe view model
import Foundation
import Combine
import CoreLocation
import MapKit

class SearchViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var searchCafeResults: [SearchCafe] = []
    @Published var nearbyCafeLocations: [SearchCafe] = []
    
    private var locationManager: CLLocationManager
    private var cancellable: AnyCancellable?
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func requestCurrentLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        self.currentLocation = location.coordinate
        self.locationManager.stopUpdatingLocation()
        self.fetchNearbyLocations(location: location)
    }
    
    func searchLocations(query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.searchCafeResults = response.mapItems.compactMap {
                guard let name = $0.name,
                      let address = $0.placemark.title else {
                    return nil
                }
                
                //TODO: ganti jadi database
                let rating = $0.pointOfInterestCategory == .cafe ? 4.5 : 4.0 // Dummy rating
                
                let totalRatings = Int.random(in: 50...500) // Dummy total ratings
                let openHours = "09:00 - 22:00" // Dummy open hours
                let distance = self?.calculateDistance(from: $0.placemark.coordinate) ?? 0.0
                return SearchCafe(name: name,
                                  coordinate: $0.placemark.coordinate,
                                  address: address,
                                  rating: rating,
                                  totalRatings: totalRatings,
                                  openHours: openHours,
                                  distance: distance)
            }
        }
    }
    
    func fetchNearbyLocations(location: CLLocation) {
        let request = MKLocalPointsOfInterestRequest(center: location.coordinate, radius: 1000)
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.restaurant, .cafe, .bakery])
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.nearbyCafeLocations = response.mapItems.compactMap {
                guard let name = $0.name,
                      let address = $0.placemark.title else {
                    return nil
                }
                
                //TODO: ganti jadi database
                let rating = $0.pointOfInterestCategory == .cafe ? 4.5 : 4.0
                let totalRatings = 0
                let openHours = "09:00 - 22:00" // Dummy open hours
                let distance = location.distance(from: CLLocation(latitude: $0.placemark.coordinate.latitude, longitude: $0.placemark.coordinate.longitude)) / 1000
                return SearchCafe(name: name,
                                  coordinate: $0.placemark.coordinate,
                                  address: address,
                                  rating: rating,
                                  totalRatings: totalRatings,
                                  openHours: openHours,
                                  distance: distance)
            }
        }
    }
    
    private func calculateDistance(from coordinate: CLLocationCoordinate2D) -> Double {
        guard let currentLocation = currentLocation else {
            return 0.0
        }
        let currentCLLocation = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
        let targetCLLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        return currentCLLocation.distance(from: targetCLLocation) / 1000 // Distance in km
    }
}




//search cafe view
import SwiftUI
import MapKit

struct SearchCafeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = SearchViewModel()
    @State private var searchQuery = ""
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack(spacing: 20) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26))
                        .foregroundColor(Color("PrimaryBase"))
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("GreyTertiary"))
                    
                    // Search Bar
                    TextField("Temukan tempat WFC", text: $searchQuery, onCommit: {
                        viewModel.searchLocations(query: searchQuery)
                    })
                    .onChange(of: searchQuery) { newQuery in
                        viewModel.searchLocations(query: newQuery)
                    }
                    
                }
                .padding()
                .background(Color("GreyLight"))
                .cornerRadius(30)
                .frame(width: 240)
                
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.system(size: 28))
                    .foregroundColor(Color("PrimaryBase"))
                    .background(
                        Color("GreyLight")
                            .frame(width: 50, height: 50) // Mengatur ukuran background secara eksplisit
                            .cornerRadius(30)
                    )
                
            }
            .padding(.leading, 27)
            
            // Search Results
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !viewModel.searchCafeResults.isEmpty {
                        Section(header:
                                    Text("Hasil Pencarian")
                            .font(
                                Font.custom("Nunito", size: 26)
                                    .weight(.semibold)
                            )
                                
                                .padding(.leading, 22)
                                .padding(.bottom, -5)
                        ) {
                            VStack(spacing: 10) {
                                ForEach(viewModel.searchCafeResults) { location in
                                    DetailSearchView(cafe: location)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                    
                    if !viewModel.nearbyCafeLocations.isEmpty {
                        Section(header:
                                    Text("Cafe Terdekat")
                            .font(
                                Font.custom("Nunito", size: 26)
                                    .weight(.semibold)
                            )
                                
                                .padding(.leading, 22)
                                .padding(.bottom, -5)
                        ) {
                            VStack(spacing: 10) {
                                ForEach(viewModel.nearbyCafeLocations) { location in
                                    DetailSearchView(cafe: location)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                }
                
            }
        }
        .padding(.top, 15)
        .onAppear {
            viewModel.requestCurrentLocation()
        }
        .navigationBarBackButtonHidden()
    }
}

struct SearchCafeView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCafeView()
    }
}


import SwiftUI
import MapKit

struct DetailSearchView: View {
    let cafe: SearchCafe
//    let reviews: [ReviewCafe]
    
    var body: some View {
//        NavigationLink(destination: PageDetailView(cafe: cafe, reviews: reviews)) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.2), radius: 4)
                    .frame(width: 344, height: 135)
                
                HStack(spacing: 5) {
                    
                    
                    ZStack(alignment: .topLeading) {
                        Image("CafeImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 130, height: 135)
                            .clipShape(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: 16,
                                    bottomLeadingRadius: 16,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 0,
                                    style: .continuous
                                )
                            )
                        
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("Star"))
                                .font(.system(size: 12))
                            
                            HStack(spacing: 3.5) {
                                //TODO: fetch database
                                Text(formatFloat(cafe.rating))
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
                                    .foregroundColor(.black)
                                Text("(\(cafe.totalRatings))")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("Grey500"))
                            }
                        }
                        .padding(8)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 16,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 0,
                                style: .continuous
                            ).fill(Color("Grey50"))
                        )
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(cafe.name)
                                .font(
                                    Font.custom("Nunito", size: 18)
                                        .weight(.bold)
                                )
                                .frame(width: 180, height: 12, alignment: .leading)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            HStack(alignment: .firstTextBaseline) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 12))
                                Text("\(cafe.address)")
                                    .font(.system(size: 12))
                                    .lineSpacing(3)
                                    .truncationMode(.tail)
                                    .frame(width: 160, height: 40, alignment: .leading)
                                    .lineLimit(2)
                            }
                            
                            HStack(alignment: .center) {
                                Image(systemName: "clock")
                                    .font(.system(size: 12))
                                HStack {
                                    Text(isOpen(now: Date(), openHours: cafe.openHours) ? "Buka" : "Tutup")
                                        .foregroundColor(isOpen(now: Date(), openHours: cafe.openHours) ? Color("GreenCorrect") : .red)
                                    Text(cafe.openHours)
                                }
                            }
                            
                            HStack(alignment: .center) {
                                Image(systemName: "road.lanes.curved.right")
                                    .font(.system(size: 12))
                                Text("\(formatFloat(cafe.distance)) km")
                            }
                            
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color("Grey500"))
                    }
                    .padding(.horizontal, 10)
                }
            }
//        }
    }
    
    private func isOpen(now: Date, openHours: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let components = openHours.split(separator: "-")
        guard components.count == 2,
              let openTime = dateFormatter.date(from: components[0].trimmingCharacters(in: .whitespaces)),
              let closeTime = dateFormatter.date(from: components[1].trimmingCharacters(in: .whitespaces)) else {
            return false
        }
        
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.hour, .minute], from: now)
        let openComponents = calendar.dateComponents([.hour, .minute], from: openTime)
        let closeComponents = calendar.dateComponents([.hour, .minute], from: closeTime)
        
        if let nowHour = nowComponents.hour, let nowMinute = nowComponents.minute,
           let openHour = openComponents.hour, let openMinute = openComponents.minute,
           let closeHour = closeComponents.hour, let closeMinute = closeComponents.minute {
            
            let nowTotalMinutes = nowHour * 60 + nowMinute
            let openTotalMinutes = openHour * 60 + openMinute
            let closeTotalMinutes = closeHour * 60 + closeMinute
            
            return nowTotalMinutes >= openTotalMinutes && nowTotalMinutes <= closeTotalMinutes
        }
        
        return false
    }
    
    private func formatFloat(_ rating: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: rating)) ?? "\(rating)"
    }
}

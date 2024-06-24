//import SwiftUI
//
//struct PageSearchView: View {
//    @State private var searchText: String = ""
//    @State private var searchHistory: [String] = ["cafe", "kopi", "NOB", "Starbucks"]
//    @State private var trendingSearches: [String] = ["Starbucks - The Breeze", "The People's Cafe - The Breeze", "J.CO - The Breeze"]
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                HStack {
//                    TextField("Search", text: $searchText)
//                        .padding(.leading, 24)
//                        .frame(height: 40)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(10)
//                        .overlay(
//                            HStack {
//                                Image(systemName: "magnifyingglass")
//                                    .foregroundColor(.gray)
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                    .padding(.leading, 8)
//                                
//                                if !searchText.isEmpty {
//                                    Button(action: {
//                                        self.searchText = ""
//                                    }) {
//                                        Image(systemName: "xmark.circle.fill")
//                                            .foregroundColor(.gray)
//                                            .padding(.trailing, 8)
//                                    }
//                                }
//                            }
//                        )
//                    
//                    Button(action: {
//                        // Action for filter button
//                    }) {
//                        Image(systemName: "line.horizontal.3.decrease.circle")
//                            .font(.system(size: 24))
//                            .padding(.leading, 8)
//                    }
//                }
//                .padding(.horizontal)
//                .padding(.top, 8)
//                
//                Text("Riwayat Pencarian")
//                    .font(.headline)
//                    .padding(.top, 16)
//                    .padding(.horizontal)
//                
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        ForEach(searchHistory, id: \.self) { item in
//                            Text(item)
//                                .padding(.horizontal, 12)
//                                .padding(.vertical, 8)
//                                .background(Color(.systemGray5))
//                                .cornerRadius(15)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                
//                Text("Trending")
//                    .font(.headline)
//                    .padding(.top, 16)
//                    .padding(.horizontal)
//                
//                List {
//                    ForEach(trendingSearches, id: \.self) { item in
//                        HStack {
//                            Image(systemName: "drop.fill")
//                                .foregroundColor(.blue)
//                            Text(item)
//                        }
//                    }
//                }
//                .listStyle(PlainListStyle())
//                
//                Spacer()
//            }
//            .navigationBarTitle("", displayMode: .inline)
//        }
//    }
//}
//
//struct PageSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        PageSearchView()
//    }
//}
//
//
//import Foundation
//import CoreLocation
//import MapKit
//
//class SearchCafe2: NSObject, ObservableObject, CLLocationManagerDelegate {
//    @Published var cafes: [ListCafe] = []
//    
//    private var locationManager: CLLocationManager?
//    
//    override init() {
//        super.init()
//        locationManager = CLLocationManager()
//        locationManager?.delegate = self
//        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
//    }
//    
//    func requestLocationPermission() {
//        locationManager?.requestWhenInUseAuthorization()
//        locationManager?.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            searchNearbyPlaces(location: location)
//            locationManager?.stopUpdatingLocation()
//        }
//    }
//    
//    func searchNearbyPlaces(location: CLLocation) {
//        let request = MKLocalPointsOfInterestRequest(center: location.coordinate, radius: 10000)
//        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.cafe, .restaurant])
//        
//        let search = MKLocalSearch(request: request)
//        search.start { [weak self] response, error in
//            guard let response = response else {
//                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            let places = response.mapItems.compactMap { item -> ListCafe? in
//                guard let name = item.name,
//                      let address = item.placemark.title,
//                      let coordinate = item.placemark.location?.coordinate else {
//                    return nil
//                }
//                
//                let distance = location.distance(from: item.placemark.location!) / 1000
//                let openHours = "09:00 - 22:00" // dummy data for open hours
//                let rating = item.placemark.title?.split(separator: " ").last.flatMap { Double($0) } ?? 0.0
//                let totalRatings = 0
//                
//                return ListCafe(name: name, address: address, openHours: openHours, distance: distance, rating: rating, totalRatings: totalRatings, coordinate: coordinate)
//            }
//            
//            DispatchQueue.main.async {
//                self?.cafes = places
//            }
//        }
//    }
//    
//    func searchPlaces(query: String) {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = query
//        
//        let search = MKLocalSearch(request: request)
//        search.start { [weak self] response, error in
//            guard let response = response else {
//                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            let places = response.mapItems.compactMap { item -> ListCafe? in
//                guard let name = item.name,
//                      let address = item.placemark.title,
//                      let coordinate = item.placemark.location?.coordinate else {
//                    return nil
//                }
//                
//                let distance = 0.0 // Assume distance is not relevant in general search
//                let openHours = "09:00 - 22:00" // dummy data for open hours
//                let rating = item.placemark.title?.split(separator: " ").last.flatMap { Double($0) } ?? 0.0
//                let totalRatings = 0
//                
//                return ListCafe(name: name, address: address, openHours: openHours, distance: distance, rating: rating, totalRatings: totalRatings, coordinate: coordinate)
//            }
//            
//            DispatchQueue.main.async {
//                self?.cafes = places
//            }
//        }
//    }
//}

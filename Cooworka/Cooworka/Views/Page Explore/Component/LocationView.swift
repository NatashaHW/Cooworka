//model data
import Foundation
import CoreLocation

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

//view model
import Foundation
import Combine
import CoreLocation
import MapKit

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var searchResults: [Location] = []
    @Published var nearbyLocations: [Location] = []
    
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
            self?.searchResults = response.mapItems.compactMap {
                Location(name: $0.name ?? "Unknown", coordinate: $0.placemark.coordinate)
            }
        }
    }
    
    func fetchNearbyLocations(location: CLLocation) {
        // Reverse geocode to get nearby areas, districts, cities, etc.
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let placemark = placemarks?.first else { return }
            var nearbyLocations: [Location] = []
            
            if let areasOfInterest = placemark.areasOfInterest {
                for area in areasOfInterest {
                    nearbyLocations.append(Location(name: area, coordinate: placemark.location!.coordinate))
                }
            }
            
            // Add other nearby locations like districts, cities, etc. if available
            if let locality = placemark.locality {
                nearbyLocations.append(Location(name: locality, coordinate: placemark.location!.coordinate))
            }
            
            if let subLocality = placemark.subLocality {
                nearbyLocations.append(Location(name: subLocality, coordinate: placemark.location!.coordinate))
            }
            
            self?.nearbyLocations = nearbyLocations
        }
    }
    
}



//select location view
import SwiftUI
import MapKit

struct SelectLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = LocationViewModel()
    @State private var searchQuery = ""
    var onLocationSelected: ((Location) -> Void)?
    var onCurrentLocationSelected: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: 75, height: 5)
                    .foregroundColor(.gray)
                    .cornerRadius(20)
                Spacer()
            }
            .padding(.top, 20)
            
            Text("Pilih Lokasi")
                .font(
                    Font.custom("Nunito", size: 26)
                        .weight(.semibold)
                )
                .padding(.leading, 25)
                .padding(.top, 8)
                
            
            VStack(spacing: 25) {
                VStack(alignment: .leading, spacing: 20) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 360, height: 50)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        HStack(spacing: 14) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Mau lihat-lihat daerah mana", text: $searchQuery)
                                .onChange(of: searchQuery, perform: { newValue in
                                    viewModel.searchLocations(query: newValue)
                                })
                            Spacer()
                        }
                        .padding(.leading, 30)
                        .padding(.trailing, 12)
                    }
                    
                    // Use Current Location Button
                    Button(action: {
                        viewModel.requestCurrentLocation()
                        onCurrentLocationSelected?()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack(spacing: 14) {
                            Image(systemName: "smallcircle.filled.circle")
                                .foregroundColor(Color("PrimaryBase"))
                                .font(.system(size: 20))
                            Text("Lokasi saat ini")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(.black)
                        }
                        //                .padding()
                    }
                    .padding(.horizontal, 30)
                }
                
                Divider()
                    .background(Color.gray)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                
                // Search Results
                //            List {
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        if !viewModel.searchResults.isEmpty {
                            Section(header:
                                        Text("Hasil Pencarian")
                                .font(
                                    Font.custom("Nunito", size: 22)
                                        .weight(.semibold)
                                )
                                    
                                    .padding(.leading, 22)
                                    .padding(.bottom, 5)
                            ) {
                                VStack(alignment: .leading, spacing: 18) {
                                    ForEach(viewModel.searchResults) { location in
                                        Button(action: {
                                            onLocationSelected?(location)
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            HStack(spacing: 14) {
                                                Image(systemName: "map")
                                                    .foregroundColor(Color("PrimaryBase"))
                                                    .font(.system(size: 20))
                                                Text(location.name)
                                                    .foregroundColor(Color(.black))
                                                    .font(.system(size: 18))
                                            }
                                            .padding(.horizontal, 30)
                                        }
                                        
                                        Divider()
                                            .background(Color.gray)
                                            .padding(.leading, 20)
                                            .padding(.trailing, 20)
                                        
                                    }
                                }
                                
                            }
                        }
                        
                        
                        
                        if !viewModel.nearbyLocations.isEmpty {
                            Section(header:
                                        Text("Area di Sekitar Kamu")
                                .font(
                                    Font.custom("Nunito", size: 22)
                                        .weight(.semibold)
                                )
                                    
                                    .padding(.leading, 22)
                                    .padding(.bottom, 5)
                            ) {
                                VStack(alignment: .leading, spacing: 18) {
                                    ForEach(viewModel.nearbyLocations) { location in
                                        Button(action: {
                                            onLocationSelected?(location)
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            HStack(spacing: 14) {
                                                Image(systemName: "map")
                                                    .foregroundColor(Color("PrimaryBase"))
                                                    .font(.system(size: 20))
                                                Text(location.name)
                                                    .foregroundColor(Color(.black))
                                                    .font(.system(size: 18))
                                            }
                                            .padding(.horizontal, 30)
                                        }
                                        
                                        Divider()
                                            .background(Color.gray)
                                            .padding(.leading, 20)
                                            .padding(.trailing, 20)
                                        
                                    }
                                }
                                
                            }
                        }
                        
                        
                    }
                }
            }
            Spacer()
            //            .listStyle(GroupedListStyle())
        }
        .onAppear {
            viewModel.requestCurrentLocation()
        }
    }
}

struct SelectLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocationView()
    }
}

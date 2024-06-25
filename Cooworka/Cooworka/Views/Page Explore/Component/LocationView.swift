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
        let request = MKLocalPointsOfInterestRequest(center: location.coordinate, radius: 1000)
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.park, .restaurant, .cafe, .museum])

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response else { return }
            self?.nearbyLocations = response.mapItems.compactMap {
                Location(name: $0.name ?? "Unknown", coordinate: $0.placemark.coordinate)
            }
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
        VStack {
            // Search Bar
            HStack {
                TextField("Search for a location", text: $searchQuery, onCommit: {
                    viewModel.searchLocations(query: searchQuery)
                })
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)

                Button(action: {
                    viewModel.searchLocations(query: searchQuery)
                }) {
                    Image(systemName: "magnifyingglass")
                }
                .padding(.trailing, 8)
            }
            .padding()

            // Use Current Location Button
            Button(action: {
                viewModel.requestCurrentLocation()
                onCurrentLocationSelected?()
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "location.fill")
                    Text("Use Current Location")
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal)

            // Search Results
            List {
                if !viewModel.searchResults.isEmpty {
                    Section(header: Text("Search Results")) {
                        ForEach(viewModel.searchResults) { location in
                            HStack {
                                Text(location.name)
                                Spacer()
                                Button("Select") {
                                    onLocationSelected?(location)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }

                if !viewModel.nearbyLocations.isEmpty {
                    Section(header: Text("Nearby Locations")) {
                        ForEach(viewModel.nearbyLocations) { location in
                            HStack {
                                Text(location.name)
                                Spacer()
                                Button("Select") {
                                    onLocationSelected?(location)
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
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

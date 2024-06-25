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
                let wifi = "Wifi Kuat"
                let powerOutlet = 2
                return SearchCafe(name: name,
                                  coordinate: $0.placemark.coordinate,
                                  address: address,
                                  rating: rating,
                                  totalRatings: totalRatings,
                                  openHours: openHours,
                                  distance: distance,
                                  wifi: wifi,
                                  powerOutlet: powerOutlet
                )
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
                let wifi = "Wifi Kuat"
                let powerOutlet = 2
                return SearchCafe(name: name,
                                  coordinate: $0.placemark.coordinate,
                                  address: address,
                                  rating: rating,
                                  totalRatings: totalRatings,
                                  openHours: openHours,
                                  distance: distance,
                                  wifi: wifi,
                                  powerOutlet: powerOutlet
                )
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

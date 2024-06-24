import Foundation
import CoreLocation
import MapKit

class SearchNearby: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var cafes: [ListCafe] = []
    
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationPermission() {
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            searchForCafes(location: location)
            locationManager?.stopUpdatingLocation()
        }
    }
    
    private func searchForCafes(location: CLLocation) {
        let request = MKLocalPointsOfInterestRequest(center: location.coordinate, radius: 300)
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.cafe, .restaurant])
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let cafes = response.mapItems.compactMap { item -> ListCafe? in
                guard let name = item.name,
                      let address = item.placemark.title,
                      let coordinate = item.placemark.location?.coordinate else {
                    return nil
                }
                
                let distance = location.distance(from: item.placemark.location!) / 1000 // Convert to kilometers
                
                // Replace the open hours, rating, and total distance with real logic to fetch the data from apple maps
                let openHours = "09:00 - 22:00"
                let rating = item.placemark.title?.split(separator: " ").last.flatMap { Double($0) } ?? 0.0
                let totalRatings = Int.random(in: 0..<100)
                
                return ListCafe(name: name, address: address, openHours: openHours, distance: distance, rating: rating, totalRatings: totalRatings, coordinate: coordinate)
            }
            
            DispatchQueue.main.async {
                self?.cafes = cafes
            }
        }
    }
}


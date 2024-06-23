//import Foundation
//import CoreLocation
//import MapKit
//
//class SearchNearby: NSObject, ObservableObject, CLLocationManagerDelegate {
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
//            searchForCafes(location: location)
//            locationManager?.stopUpdatingLocation()
//        }
//    }
//    
//    private func searchForCafes(location: CLLocation) {
//        let request = MKLocalPointsOfInterestRequest(center: location.coordinate, radius: 5000)
//        request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.cafe, .restaurant])
//        
//        let search = MKLocalSearch(request: request)
//        search.start { [weak self] response, error in
//            guard let response = response else {
//                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//            
//            let cafes = response.mapItems.compactMap { item -> ListCafe? in
//                guard let name = item.name,
//                      let address = item.placemark.title,
//                      let coordinate = item.placemark.location?.coordinate else {
//                    return nil
//                }
//                
//                // Assuming we have some way to get these details
//                let openHours = "09:00 - 22:00" // Placeholder
//                let rating = item.placemark.title?.split(separator: " ").last.flatMap { Double($0) } ?? 0.0
//                let distance = location.distance(from: item.placemark.location!) / 1000 // Convert to kilometers
//                
//                return ListCafe(name: name, address: address, openHours: openHours, rating: rating, distance: distance, coordinate: coordinate)
//            }
//            
//            DispatchQueue.main.async {
//                self?.cafes = cafes
//            }
//        }
//    }
//}

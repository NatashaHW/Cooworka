import Foundation
import CoreLocation
import MapKit

struct ListCafe: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let openHours: String
    let rating: Double
    let totalRatings: Int
    let distance: Double
    let coordinate: CLLocationCoordinate2D
}

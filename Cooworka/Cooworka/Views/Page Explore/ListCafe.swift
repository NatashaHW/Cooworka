import Foundation
import CoreLocation
import MapKit

struct ListCafe: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let openHours: String
    let distance: Double
    
    var price: String?
    var wifi: String?
    var powerOutlet: String?

    var taste: Double?
    var ambience: Double?
    var service: Double?
    
    // TODO: ini harusnya ganti jadi logic sama dia opsional ga si?
    var rating: Double
    //            var rating = (taste + ambience + service) / 3
    //ini juga opsional ga si
    var totalRatings: Int
    
    let coordinate: CLLocationCoordinate2D
}

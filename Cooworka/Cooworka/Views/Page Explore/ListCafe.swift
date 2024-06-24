import Foundation
import CoreLocation
import MapKit

struct ListCafe: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let openHours: String
    let distance: Double
    
    // TODO: ini harusnya ganti jadi logic tampilin yg plg banyak org pilih
    // tampilin yg plg banyak org pilih
    var price: String?
    // tampilin yg plg banyak org pilih
    var wifi: String?
    // tampilin yg plg banyak org pilih
    var powerOutlet: Int?

    var taste: Double?
    var ambience: Double?
    var service: Double?

    
    // TODO: ini harusnya ganti jadi logic sama dia opsional ga si?
    var rating: Double
    //            var rating = (taste + ambience + service) / 3
    //ini juga opsional ga si
    var totalRatings: Int
    
    //TODO: Notes: sher ini gw integer, tapi di database nanti boolean yes no question (nah lu count jumlah yes nya)
    var totalMakananBerat: Int?
    var totalErgonomis: Int?
    var totalMeetingRoom: Int?
    var totalSmokingRoom: Int?
    var totalParkiranMobil: Int?
    var totalParkiranMotor: Int?
    var totalPrayerRoom: Int?
    
    
    
    let coordinate: CLLocationCoordinate2D
}

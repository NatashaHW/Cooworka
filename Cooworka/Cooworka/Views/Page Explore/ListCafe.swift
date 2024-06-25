//import Foundation
//import CoreLocation
//import MapKit
//
//struct ListCafe: Identifiable {
//    // TODO: ini samain ID nya, ID nya generate nya dari database nya kan? -> pas di save
//    var id = UUID()
//    // TODO: untuk saat ini, cara gw nampilin review di suatu cafe dengan nyamain namanya -> bisa lu ubah logic nya
//    // Cuman gw agak bingung, berarti pas search kan belum masuk ke database, dia masuk database waktu di klik, nah cara kita tau cafe itu udah kita save ke database atau belum gimana? kan UUID nya baru aada pas di save... apa bandingin nama sama coordinate aja? -> kalo belum ada yang sama -> save jadi UUID baru
//    let name: String
//    let address: String
//    let openHours: String
//    let distance: Double
//
//    // TODO: ini harusnya ganti jadi logic tampilin yg plg banyak org pilih
//    // tampilin yg plg banyak org pilih
//    var price: String?
//    // tampilin yg plg banyak org pilih
//    var wifi: String?
//    // tampilin yg plg banyak org pilih
//    var powerOutlet: Int?
//
//    var taste: Double?
//    var ambience: Double?
//    var service: Double?
//
//
//    // TODO: ini harusnya ganti jadi logic sama dia opsional ga si?
//    var rating: Double
//    //            var rating = (taste + ambience + service) / 3
//    //ini juga opsional ga si
//    var totalRatings: Int
//
//    //TODO: Notes: sher ini gw integer, tapi di database nanti boolean yes no question (nah lu count jumlah yes nya)
//    var totalMakananBerat: Int?
//    var totalErgonomis: Int?
//    var totalMeetingRoom: Int?
//    var totalSmokingRoom: Int?
//    var totalParkiranMobil: Int?
//    var totalParkiranMotor: Int?
//    var totalPrayerRoom: Int?
//
//
//
//    let coordinate: CLLocationCoordinate2D
//
//    init(from searchCafe: SearchCafe) {
//            self.id = searchCafe.id
//            self.name = searchCafe.name
//            self.coordinate = searchCafe.coordinate
//            self.address = searchCafe.address
//            self.rating = searchCafe.rating
//            self.totalRatings = searchCafe.totalRatings
//            self.openHours = searchCafe.openHours
//            self.distance = searchCafe.distance
//        }
//}
//
//import Foundation
//import CoreLocation
//
//struct ListCafe: Identifiable {
//    let id = UUID()
//    let name: String
//    let coordinate: CLLocationCoordinate2D
//    let address: String
//    let rating: Double
//    let totalRatings: Int
//    let openHours: String
//    let distance: Double
//    let taste: Double
//    let ambience: Double
//    let service: Double
//
//    // Custom initializer to convert from SearchCafe
//    init(from searchCafe: SearchCafe) {
//        self.name = searchCafe.name
//        self.coordinate = searchCafe.coordinate
//        self.address = searchCafe.address
//        self.rating = searchCafe.rating
//        self.totalRatings = searchCafe.totalRatings
//        self.openHours = searchCafe.openHours
//        self.distance = searchCafe.distance
//        self.taste = 4.0 // Example default value
//        self.ambience = 4.5 // Example default value
//        self.service = 4.7 // Example default value
//    }
//
//    // Default initializer
//    init(name: String, address: String, openHours: String, distance: Double, taste: Double, ambience: Double, service: Double, rating: Double, totalRatings: Int, coordinate: CLLocationCoordinate2D) {
//        self.name = name
//        self.address = address
//        self.openHours = openHours
//        self.distance = distance
//        self.taste = taste
//        self.ambience = ambience
//        self.service = service
//        self.rating = rating
//        self.totalRatings = totalRatings
//        self.coordinate = coordinate
//    }
//}
//

import Foundation
import CoreLocation
import MapKit

struct ListCafe: Identifiable {
    var id = UUID()
    let name: String
    let address: String
    let openHours: String
    let distance: Double
    var price: String?
    var wifi: String?
    var powerOutlet: Int?
    var taste: Double?
    var ambience: Double?
    var service: Double?
    var rating: Double
    var totalRatings: Int
    var totalMakananBerat: Int?
    var totalErgonomis: Int?
    var totalMeetingRoom: Int?
    var totalSmokingRoom: Int?
    var totalParkiranMobil: Int?
    var totalParkiranMotor: Int?
    var totalPrayerRoom: Int?
    let coordinate: CLLocationCoordinate2D
    
    init(from searchCafe: SearchCafe) {
        self.id = searchCafe.id
        self.name = searchCafe.name
        self.coordinate = searchCafe.coordinate
        self.address = searchCafe.address
        self.rating = searchCafe.rating
        self.totalRatings = searchCafe.totalRatings
        self.openHours = searchCafe.openHours
        self.distance = searchCafe.distance
        self.wifi = searchCafe.wifi
        self.powerOutlet = searchCafe.powerOutlet
    }
    
    // Custom initializer for ListCafe
    init(id: UUID = UUID(), name: String, address: String, openHours: String, distance: Double, price: String? = nil, wifi: String? = nil, powerOutlet: Int? = nil, taste: Double? = nil, ambience: Double? = nil, service: Double? = nil, rating: Double, totalRatings: Int, totalMakananBerat: Int? = nil, totalErgonomis: Int? = nil, totalMeetingRoom: Int? = nil, totalSmokingRoom: Int? = nil, totalParkiranMobil: Int? = nil, totalParkiranMotor: Int? = nil, totalPrayerRoom: Int? = nil, coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.address = address
        self.openHours = openHours
        self.distance = distance
        self.price = price
        self.wifi = wifi
        self.powerOutlet = powerOutlet
        self.taste = taste
        self.ambience = ambience
        self.service = service
        self.rating = rating
        self.totalRatings = totalRatings
        self.totalMakananBerat = totalMakananBerat
        self.totalErgonomis = totalErgonomis
        self.totalMeetingRoom = totalMeetingRoom
        self.totalSmokingRoom = totalSmokingRoom
        self.totalParkiranMobil = totalParkiranMobil
        self.totalParkiranMotor = totalParkiranMotor
        self.totalPrayerRoom = totalPrayerRoom
        self.coordinate = coordinate
    }
}

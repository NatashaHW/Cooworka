import Foundation
import CoreLocation
import MapKit

struct ListCafe: Identifiable {
    // TODO: ini samain ID nya, ID nya generate nya dari database nya kan? -> pas di save
    let id = UUID()
    // TODO: untuk saat ini, cara gw nampilin review di suatu cafe dengan nyamain namanya -> bisa lu ubah logic nya
    // Cuman gw agak bingung, berarti pas search kan belum masuk ke database, dia masuk database waktu di klik, nah cara kita tau cafe itu udah kita save ke database atau belum gimana? kan UUID nya baru aada pas di save... apa bandingin nama sama coordinate aja? -> kalo belum ada yang sama -> save jadi UUID baru
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

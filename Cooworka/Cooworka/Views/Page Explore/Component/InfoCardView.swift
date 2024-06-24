import SwiftUI
import MapKit

struct InfoCardView: View {
    let cafe: ListCafe
    @State private var isExpanded = false
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        
        // TODO: fetch data dari database
        //Tambahin logic taste, ambience, service itu dapat dari avg review yang diisi user
        var taste = cafe.taste ?? 0
        var ambience = cafe.ambience ?? 0
        var service = cafe.service ?? 0
        var powerOutlet = cafe.powerOutlet ?? -1
        var price = cafe.price ?? "No Data"
        var wifi = cafe.wifi ?? "No Data"
        
        // TODO: fetch data dari database + logic
        var totalMakananBerat = cafe.totalMakananBerat ?? 0
        var totalErgonomis = cafe.totalErgonomis ?? 0
        var totalMeetingRoom = cafe.totalMeetingRoom ?? 0
        var totalSmokingRoom = cafe.totalSmokingRoom ?? 0
        var totalParkiranMobil = cafe.totalParkiranMobil ?? 0
        var totalParkiranMotor = cafe.totalParkiranMotor ?? 0
        var totalPrayerRoom = cafe.totalPrayerRoom ?? 0
        
        ZStack(alignment: .topLeading) {
            UnevenRoundedRectangle(
                topLeadingRadius: 16,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 16,
                style: .continuous
            )
            .foregroundColor(.white)
            .frame(maxWidth: screenWidth)
            .edgesIgnoringSafeArea(.all)
            .shadow(color: .black.opacity(0.2), radius: 4)
            
            VStack(alignment: .center, spacing: 30) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        
                        Spacer()
                        
                        //Star Rating
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("Star"))
                                .font(.system(size: 12))
                            
                            HStack(spacing: 3.5) {
                                Text(formatFloat(cafe.rating))
                                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                                    .foregroundColor(.black)
                                Text("(\(cafe.totalRatings))")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("Grey500"))
                            }
                        }
                        .padding(8)
                        .background(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 16,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 16,
                                style: .continuous
                            ).fill(Color("Grey50"))
                        )
                    }
                    .padding(.trailing, -20)
                    
                    HStack() {
                        // Cafe Name
                        Text(cafe.name)
                            .font(
                                Font.custom("Nunito", size: 24)
                                    .weight(.heavy)
                            )
                            .frame(width: 270, height: 12, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(formatFloat(cafe.distance)) km")
                            .foregroundColor(Color("Grey400"))
                            .font(.system(size: 13))
                    }
                    
                    HStack(spacing: 12) {
                        RatingView(title: "Rasa", rating: taste)
                        RatingView(title: "Suasana", rating: ambience)
                        RatingView(title: "Pelayanan", rating: service)
                    }
                    
                    VStack(alignment: .leading, spacing: 20) {
                        InfoRow(cafe: cafe, imageSystemName: "clock", detail: cafe.openHours)
                            .padding(.horizontal, 5)
                        InfoRow(cafe: cafe, imageSystemName: "mappin.and.ellipse", detail: cafe.address)
                            .padding(.horizontal, 5)
                        
                        
                        if (price != "No Data") {
                            HStack(alignment: .top, spacing: 0) {
                                InfoRow(cafe: cafe, imageSystemName: "tag", detail: price)
                                
                                Text(" / orang")
                                    .font(.system(size: 13, weight: .regular))
                            }
                            .padding(.horizontal, 5)
                        }
                        
                        if (powerOutlet != -1) {
                            InfoRow(cafe: cafe, imageSystemName: "powerplug", detail: "\(powerOutlet) stop kontak / meja")
                                .padding(.horizontal, 5)
                        }
                        
                        if (wifi != "No Data") {
                            InfoRow(cafe: cafe, imageSystemName: "wifi", detail: wifi)
                                .padding(.horizontal, 5)
                        }
                    }
                    
                    // Info tambahan yang akan di-expand/collapse
                    if isExpanded {
                        VStack(alignment: .leading, spacing: 20) {
                            if (price == "No Data") {
                                InfoRow(cafe: cafe, imageSystemName: "tag", detail: price)
                            }
                            
                            if (powerOutlet == -1) {
                                InfoRow(cafe: cafe, imageSystemName: "powerplug", detail: "No Data")
                            }
                            
                            VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Makanan")
                                    .font(.system(size: 16, weight: .semibold))
                                
                                ExpandInfo(imageName: "fork.knife", title: "Makanan Berat", count: totalMakananBerat)
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Fasilitas")
                                    .font(.system(size: 16, weight: .semibold))
                                
                                HStack {
                                    // Ergonomis
                                    ExpandInfo(imageName: "chair.lounge.fill", title: "Ergonomis", count: totalErgonomis)
                                    
                                    // Meeting Room
                                    ExpandInfo(imageName: "person.3.fill", title: "Ruang Meeting", count: totalMeetingRoom)
                                }
                                HStack {
                                    // Prayer Room
                                    ExpandInfo(imageName: "chair.lounge.fill", title: "Prayer Room", count: totalPrayerRoom)
                                    
                                    // Smoking Area
                                    ExpandInfo(imageName: "chair.lounge.fill", title: "Area Merokok", count: totalSmokingRoom)
                                }
                                
                                //Parkiran
                                ExpandInfoParkiran(imageName: "car.fill", totalParkiranMobil: totalParkiranMobil, totalParkiranMotor: totalParkiranMotor)
                                
                            }
                        }
                        }
                        .padding(.horizontal, 5)
                        .padding(.bottom, 20)
                    }
                    
                    
                    
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .font(.system(size: 15))
                    .onTapGesture {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }
                    .padding(.bottom, 16)
            }
        }
    }
}

struct RatingView: View {
    let title: String
    let rating: Double?
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.black)
            
            HStack(spacing: 3) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color("Star"))
                    .font(.system(size: 10))
                
                Text(formatFloat(rating ?? 0))
                    .font(.system(size: 12))
                    .foregroundColor(.black)
            }
            
        }
        .padding(8)
        .background(Color("Grey50"))
        .cornerRadius(10)
    }
    
    private func formatFloat(_ rating: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: rating)) ?? "\(rating)"
    }
}


struct InfoRow: View {
    let cafe: ListCafe
    let imageSystemName: String
    let detail: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: imageSystemName)
                .font(.system(size: 13))
            
            HStack {
                if imageSystemName == "clock" {
                    Text(isOpen(now: Date(), openHours: cafe.openHours) ? "Buka" : "Tutup")
                        .foregroundColor(isOpen(now: Date(), openHours: cafe.openHours) ? Color("GreenCorrect") : .red)
                        .font(.system(size: 13, weight: .regular))
                    
                }
                
                Text(detail)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
            }
        }
    }
    
    private func isOpen(now: Date, openHours: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let components = openHours.split(separator: "-")
        guard components.count == 2,
              let openTime = dateFormatter.date(from: components[0].trimmingCharacters(in: .whitespaces)),
              let closeTime = dateFormatter.date(from: components[1].trimmingCharacters(in: .whitespaces)) else {
            return false
        }
        
        let calendar = Calendar.current
        let nowComponents = calendar.dateComponents([.hour, .minute], from: now)
        let openComponents = calendar.dateComponents([.hour, .minute], from: openTime)
        let closeComponents = calendar.dateComponents([.hour, .minute], from: closeTime)
        
        if let nowHour = nowComponents.hour, let nowMinute = nowComponents.minute,
           let openHour = openComponents.hour, let openMinute = openComponents.minute,
           let closeHour = closeComponents.hour, let closeMinute = closeComponents.minute {
            
            let nowTotalMinutes = nowHour * 60 + nowMinute
            let openTotalMinutes = openHour * 60 + openMinute
            let closeTotalMinutes = closeHour * 60 + closeMinute
            
            return nowTotalMinutes >= openTotalMinutes && nowTotalMinutes <= closeTotalMinutes
        }
        
        return false
    }
}


struct ExpandInfo: View {
    let imageName: String
    let title: String
    let count: Int
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if imageName == "person.3.fill" {
                Image(systemName: imageName)
                    .font(.system(size: 11))
            } else {
                Image(systemName: imageName)
                    .font(.system(size: 13))
            }
            
            HStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
                Text("(\(count))")
                    .font(.system(size: 13))
                    .foregroundColor(Color("Grey500"))
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 8)
        .background(Color("Grey50"))
        .frame(height: 30)
        .cornerRadius(5)
    }
}



struct ExpandInfoParkiran: View {
    let imageName: String
    let title: String
    let count: Int
    
    init(imageName: String, totalParkiranMobil: Int, totalParkiranMotor: Int) {
        self.imageName = imageName
        
        if totalParkiranMobil > 0 && totalParkiranMotor > 0 {
            self.title = "Parkiran Mobil & Motor"
            self.count = totalParkiranMobil + totalParkiranMotor
        } else if totalParkiranMobil > 0 && totalParkiranMotor == 0 {
            self.title = "Parkiran Mobil"
            self.count = totalParkiranMobil
        } else if totalParkiranMobil == 0 && totalParkiranMotor > 0 {
            self.title = "Parkiran Motor"
            self.count = totalParkiranMotor
        } else {
            self.title = "Parkiran"
            self.count = 0
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 13))
            
            HStack(spacing: 5) {
                Text(title)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.black)
                Text("(\(count))")
                    .font(.system(size: 13))
                    .foregroundColor(Color("Grey500"))
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 8)
        .background(Color("Grey50"))
        .frame(height: 30)
        .cornerRadius(5)
    }
}


// Sample data for preview
let exampleCafe2 = ListCafe(
    name: "NOB Cafe, The Breeze BSD",
    address: "The Breeze, Jl. Grand Boulevard, BSD, Serpong, Tangerang Selatan",
    openHours: "09:00 - 22:00",
    distance: 2.5,
    taste: 4.0,
    ambience: 4.5,
    service: 4.7,
    rating: 0, totalRatings: 120,
    coordinate: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
)


struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardView(cafe: exampleCafe2)
    }
}

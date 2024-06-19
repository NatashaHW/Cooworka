import SwiftUI
import MapKit

struct PageReview: View {
    @StateObject private var viewModel = SearchNearby()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack (spacing: 20) {
                    ForEach(viewModel.cafes) { cafe in
                        CafeCardView(cafe: cafe)
                            .onTapGesture {
                                openInMaps(cafe: cafe)
                            }
                    }
                }
            }
            .navigationTitle("Review Cafe Terdekat")
            .onAppear {
                viewModel.requestLocationPermission()
            }
        }
    }
    
    private func openInMaps(cafe: ListCafe) {
        let placemark = MKPlacemark(coordinate: cafe.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = cafe.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

struct CafeCardView: View {
    let cafe: ListCafe
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            VStack(spacing: 18) {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 344, height: 128)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Text(cafe.name)
                            .font(
                                Font.custom("Nunito", size: 20)
                                    .weight(.bold)
                            )
                            .frame(width: 220, height: 12, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Spacer().frame(width: 34.5)
                        
                        
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("Star"))
                                .font(.system(size: 12))
                            Text(formatFloat(cafe.rating))
                                .font(.system(size: 12, weight: .medium, design: .rounded))
                                .foregroundColor(.black)
                        }
                        .padding(6)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color("Grey50"))
                        )
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        HStack(alignment: .top) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 12))
                            Text(cafe.address)
                                .font(.system(size: 12, weight: .regular))
                                .frame(width: 263, alignment: .topLeading)
                                .lineLimit(2)
                                .truncationMode(.tail)
                        }
                        
                        HStack(alignment: .center) {
                            Image(systemName: "clock")
                                .font(.system(size: 12))
                            HStack {
                                Text(isOpen(now: Date(), openHours: cafe.openHours) ? "Buka" : "Tutup")
                                    .foregroundColor(isOpen(now: Date(), openHours: cafe.openHours) ? Color("Green") : .red)
                                Text(cafe.openHours)
                            }
                        }
                        
                        
                        HStack(alignment: .top) {
                            Image(systemName: "road.lanes.curved.right")
                                .font(.system(size: 12))
                            Text("\(formatFloat(cafe.distance)) km")
                        }
                        
                        
                    }
                    .font(.system(size: 12))
                    .foregroundColor(Color("Grey500"))
                }
            }
            Button(action: {}) {
                Text("Check In +10 XP")
                    .font(
                        Font.custom("Nunito", size: 14)
                            .weight(.bold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(width: 294, height: 32)
                    .padding(2.5)
                    .background(Color("Primary"))
                    .cornerRadius(32)
            }
        }
        .padding(.bottom, 25)
        .frame(width: 344, height: 294)
        .background(Color("GreyWhite"))
        .cornerRadius(16)
        .shadow(color: Color("Shadow").opacity(0.5), radius: 5)
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
    
    private func formatFloat(_ rating: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: rating)) ?? "\(rating)"
    }
}

struct ListCafe: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let openHours: String
    let rating: Double
    let distance: Double
    let coordinate: CLLocationCoordinate2D
}

#Preview {
    PageReview()
}

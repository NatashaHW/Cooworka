import SwiftUI
import MapKit

struct PageDetailView: View {
    let cafe: ListCafe
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: -75) {
                Image("CafeImage")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 280)
                    .clipped()
                    .edgesIgnoringSafeArea(.top)
                
                InfoCardView(cafe: cafe)
                
                Spacer()
                
                //            Spacer()
                
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 110)
                        .foregroundColor(.white)
                        .shadow(radius:10)
                    
//                    NavigationLink(destination: PageReview) {
                        Text("Klaim Hadiah")
                            .font(
                                Font.custom("Nunito", size: 24)
                                    .weight(.bold)
                            )
                            .padding(.horizontal, 100)
                            .padding(.vertical, 18)
                            .foregroundColor(.white)
                            .background(Color("PrimaryBase"))
                            .cornerRadius(15)
                        
//                    }
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    
                    
                }
                
                
                
            }
            .edgesIgnoringSafeArea(.bottom)
//            .navigationBarTitle("Cafe Details", displayMode: .inline)
        }
    }
}

// Data contoh untuk preview
let exampleCafe = ListCafe(
    name: "Cafe Contoh",
    address: "Jl. Contoh No. 123, Kota Contoh a a a a a a  bbb csdsa  dx acefaad dcsvefad xcdedscdvrfced",
    openHours: "08:00 - 22:00",
    distance: 2.5, 
    taste: 4.0,
    ambience: 4.5,
    service: 4.7,
    rating: 0, totalRatings: 120,
    coordinate: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
)

// Preview struct
struct PageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PageDetailView(cafe: exampleCafe)
    }
}



struct InfoCardView: View {
    let cafe: ListCafe
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        NavigationLink(destination: PageDetailView(cafe: cafe)) {
            // TODO: fetch data dari database
            //Tambahin logic taste, ambience, service itu dapat dari avg review yang diisi user
            var taste = cafe.taste ?? 0
            var ambience = cafe.ambience ?? 0
            var service = cafe.service ?? 0
            
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
                                    .font(.system(size: 12, weight: .medium, design: .rounded))
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
                                    .weight(.bold)
                            )
                            .frame(width: 180, height: 12, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Text("\(formatFloat(cafe.distance)) km")
                    }
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 8) {
                            Text("Rasa")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 3) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("Star"))
                                    .font(.system(size: 10))
                                
                                Text(formatFloat(taste))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(8)
                        .background(Color("Grey50"))
                        .cornerRadius(10)
                        
                        
                        HStack(spacing: 8) {
                            Text("Suasana")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 3) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("Star"))
                                    .font(.system(size: 10))
                                
                                Text(formatFloat(ambience))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(8)
                        .background(Color("Grey50"))
                        .cornerRadius(10)
                        
                        
                        HStack(spacing: 8) {
                            Text("Pelayanan")
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            
                            HStack(spacing: 3) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(Color("Star"))
                                    .font(.system(size: 10))
                                
                                Text(formatFloat(service))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            
                        }
                        .padding(8)
                        .background(Color("Grey50"))
                        .cornerRadius(10)
                        
                    }
                    
                    VStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 14) {
                            // Open Hours
                            HStack(alignment: .center, spacing: 25) {
                                Image(systemName: "clock")
                                    .font(.system(size: 12))
                                HStack {
                                    Text(isOpen(now: Date(), openHours: cafe.openHours) ? "Buka" : "Tutup")
                                        .foregroundColor(isOpen(now: Date(), openHours: cafe.openHours) ? Color("GreenCorrect") : .red)
                                    Text(cafe.openHours)
                                }
                            }
                            
                            // Address
                            HStack(alignment: .top, spacing: 25) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.system(size: 12))
                                Text(cafe.address)
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(maxWidth: screenWidth - 20, alignment: .topLeading)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            // Price
                            HStack(alignment: .center, spacing: 25) {
                                Image(systemName: "dollarsign.circle")
                                    .font(.system(size: 12))
                                // TODO: fetch data dari database
                                Text(cafe.price ?? "No Data")
                                    .font(.system(size: 12, weight: .regular))
                            }
                            
                            // Power Outlet
                            HStack(alignment: .center, spacing: 25) {
                                Image(systemName: "powerplug")
                                    .font(.system(size: 10))
                                // TODO: fetch data dari database
                                Text(cafe.powerOutlet ?? "No Data")
                                    .font(.system(size: 12, weight: .regular))
                            }
                            
                            // Wifi
                            HStack(alignment: .center, spacing: 25) {
                                Image(systemName: "wifi")
                                    .font(.system(size: 12))
                                // TODO: fetch data dari database
                                Text(cafe.wifi ?? "No Data")
                                    .font(.system(size: 12, weight: .regular))
                            }
                            
                        }
                        .font(.system(size: 12))
                        .foregroundColor(Color("Grey500"))
                        
                        Button(action: {
                            // Action for claiming the reward
                        }) {
                            Image(systemName: "chevron.down")
                                .font(.system(size: 15))
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
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
    
    private func formatFloat(_ rating: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: rating)) ?? "\(rating)"
    }
}

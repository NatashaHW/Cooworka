//import SwiftUI
//import MapKit
//
//struct PageDetailView2: View {
//    let cafe: ListCafe
//    
//    private var screenWidth: CGFloat {
//        UIScreen.main.bounds.width
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            VStack(alignment: .center, spacing: -90) {
//                Image("CafeImage")
//                    .resizable()
//                    .scaledToFill()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(maxWidth: .infinity, maxHeight: 280)
//                    .clipped()
//                    .edgesIgnoringSafeArea(.top)
//                
//                UnevenRoundedRectangle(
//                    topLeadingRadius: 16,
//                    bottomLeadingRadius: 0,
//                    bottomTrailingRadius: 0,
//                    topTrailingRadius: 16,
//                    style: .continuous
//                )
//                .foregroundColor(.white)
//                .frame(height: 40)
//                
//            }
//            
//            VStack(alignment: .leading, spacing: 8) {
//                Text(cafe.name)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                
//                HStack {
//                    Image(systemName: "mappin.and.ellipse")
//                    Text(cafe.address)
//                }
//                .font(.subheadline)
//                .foregroundColor(.gray)
//                
//                HStack {
//                    Image(systemName: "star.fill")
//                        .foregroundColor(Color("Star"))
//                    Text("\(cafe.rating, specifier: "%.1f") (\(cafe.totalRatings) reviews)")
//                }
//                .font(.subheadline)
//                
//                HStack {
//                    Image(systemName: "road.lanes.curved.right")
//                    Text("\(cafe.distance, specifier: "%.2f") km")
//                }
//                .font(.subheadline)
//                
//                HStack {
//                    Image(systemName: "clock")
//                    Text(cafe.openHours)
//                        .foregroundColor(isOpen(now: Date(), openHours: cafe.openHours) ? .green : .red)
//                }
//                .font(.subheadline)
//            }
//            .padding(.horizontal)
//            
//            
//            
//            Spacer()
//        }
//        //        .padding()
//        .navigationBarTitle("Cafe Details", displayMode: .inline)
//        
//    }
//    
//    private func isOpen(now: Date, openHours: String) -> Bool {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm"
//        
//        let components = openHours.split(separator: "-")
//        guard components.count == 2,
//              let openTime = dateFormatter.date(from: components[0].trimmingCharacters(in: .whitespaces)),
//              let closeTime = dateFormatter.date(from: components[1].trimmingCharacters(in: .whitespaces)) else {
//            return false
//        }
//        
//        let calendar = Calendar.current
//        let nowComponents = calendar.dateComponents([.hour, .minute], from: now)
//        let openComponents = calendar.dateComponents([.hour, .minute], from: openTime)
//        let closeComponents = calendar.dateComponents([.hour, .minute], from: closeTime)
//        
//        if let nowHour = nowComponents.hour, let nowMinute = nowComponents.minute,
//           let openHour = openComponents.hour, let openMinute = openComponents.minute,
//           let closeHour = closeComponents.hour, let closeMinute = closeComponents.minute {
//            
//            let nowTotalMinutes = nowHour * 60 + nowMinute
//            let openTotalMinutes = openHour * 60 + openMinute
//            let closeTotalMinutes = closeHour * 60 + closeMinute
//            
//            return nowTotalMinutes >= openTotalMinutes && nowTotalMinutes <= closeTotalMinutes
//        }
//        
//        return false
//    }
//}
//
//// Data contoh untuk preview
//let exampleCafe2 = ListCafe(
//    name: "Cafe Contoh",
//    address: "Jl. Contoh No. 123, Kota Contoh",
//    openHours: "08:00 - 22:00",
//    rating: 4.5,
//    totalRatings: 120,
//    distance: 2.5,
//    coordinate: CLLocationCoordinate2D(latitude: -6.2088, longitude: 106.8456)
//)
//
//// Preview struct
//struct PageDetailView_Previews2: PreviewProvider {
//    static var previews: some View {
//        PageDetailView2(cafe: exampleCafe2)
//    }
//}

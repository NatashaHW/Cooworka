import SwiftUI
import MapKit

struct DetailCardView: View {
    let cafe: ListCafe

    var body: some View {

        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 4)
                .frame(width: 344, height: 135)
            
            HStack(spacing: 5) {
                
                
                ZStack(alignment: .topLeading) {
                    Image("CafeImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 130, height: 135)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 16,
                                bottomLeadingRadius: 16,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0,
                                style: .continuous
                            )
                    )
                    
                        HStack(spacing: 5) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color("Star"))
                                .font(.system(size: 12))
                            
                            HStack(spacing: 3.5) {
                                //TODO: fetch database
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
                                topLeadingRadius: 16,
                                bottomLeadingRadius: 0,
                                bottomTrailingRadius: 16,
                                topTrailingRadius: 0,
                                style: .continuous
                            ).fill(Color("Grey50"))
                        )
                    
                }

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text(cafe.name)
                            .font(
                                Font.custom("Nunito", size: 18)
                                    .weight(.bold)
                            )
                            .frame(width: 180, height: 12, alignment: .leading)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }

                    VStack(alignment: .leading, spacing: 8) {

                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "mappin.and.ellipse")
                                .font(.system(size: 12))
                            Text("\(cafe.address)")
                                .font(.system(size: 12))
                                .lineSpacing(3)
                                .truncationMode(.tail)
                                .frame(width: 160, height: 40, alignment: .leading)
                                .lineLimit(2)
                        }

                        HStack(alignment: .center) {
                            Image(systemName: "clock")
                                .font(.system(size: 12))
                            HStack {
                                Text(isOpen(now: Date(), openHours: cafe.openHours) ? "Buka" : "Tutup")
                                    .foregroundColor(isOpen(now: Date(), openHours: cafe.openHours) ? Color("GreenCorrect") : .red)
                                Text(cafe.openHours)
                            }
                        }

                        HStack(alignment: .center) {
                            Image(systemName: "road.lanes.curved.right")
                                .font(.system(size: 12))
                            Text("\(formatFloat(cafe.distance)) km")
                        }
                        
                    }
                    .font(.system(size: 12))
                    .foregroundColor(Color("Grey500"))
                }
                .padding(.horizontal, 10)
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


#Preview {
    DetailCardView(cafe: exampleCafe)
}

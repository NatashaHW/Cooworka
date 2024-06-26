import SwiftUI
import MapKit

struct CafeCardMini: View {
    let cafe: ListCafe
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.2), radius: 4)
                .frame(width: 344, height: 90)
            
            HStack(spacing: 9) {
                ZStack(alignment: .topLeading) {
                    Image("CafeImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 90)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 16,
                                bottomLeadingRadius: 16,
                                bottomTrailingRadius: 0,
                                topTrailingRadius: 0,
                                style: .continuous
                            )
                        )
                    
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text(cafe.name)
                        .font(
                            Font.custom("Nunito", size: 18)
                                .weight(.bold)
                        )
                        .frame(width: 200, height: 12, alignment: .leading)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                        .padding(.top, 6)
                    
                    //TODO: ganti jadi tanggal saat dia pencet klaim reward (check in)
                    Text("Dikunjungi pada 27 Juni 2024")
                        .font(.system(size: 12))
                        .foregroundColor(Color("Grey500"))
                    
                }
                .padding(.horizontal, 10)
            }
        }
    }
    
   
}

#Preview {
    CafeCardMini(cafe: exampleCafe)
}

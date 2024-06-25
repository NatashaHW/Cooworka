import SwiftUI

struct WardrobeView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: .infinity)
                        .foregroundColor(.backgroundProfile)
                    
                    Circle()
                        .scale(2)
                        .offset(y: 425)
                        .foregroundColor(.lightBlueForPopUp)
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
                Image("BudakJompo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 390, height: 390)
                    .padding(.top, 50)
                
            }
            
            SunglassesView()
                .padding(.bottom, -50)
            
        }
    }
}

#Preview {
    WardrobeView()
}

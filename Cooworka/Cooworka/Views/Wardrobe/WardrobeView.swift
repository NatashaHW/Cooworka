import SwiftUI

struct WardrobeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
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
                
                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 40, height: 40)
                                        .overlay(
                                            Image(systemName: "arrow.left")
                                                .font(.system(size: 20))
                                                .foregroundColor(.black)
                                        )
                                }
                                .padding()
                                .padding(.leading, 20)
                                .padding(.top, -20)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    WardrobeView()
}

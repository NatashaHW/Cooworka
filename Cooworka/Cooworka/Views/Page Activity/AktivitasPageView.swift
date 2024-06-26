import SwiftUI
import MapKit

struct AktivitasPageView: View {
    @StateObject private var viewModel = SearchNearby()
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading, spacing: 30) {
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Aktivitas")
                        .font(.system(size: 26, weight: .bold))
                    
                    HStack {
                        
                        NavigationLink(destination: AktivitasPageView()){
                            ZStack {
                                Rectangle()
                                    .frame(width: 168, height: 38)
                                    .foregroundColor(.clear)
                                
                                VStack(spacing: 3) {
                                    Text("Riwayat")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(Color("PrimaryBase"))
                                    Rectangle()
                                        .frame(width: 75, height: 2)
                                        .foregroundColor(Color("PrimaryBase"))
                                        .cornerRadius(5)
                                }
                                
                            }
                        }
                        
                        NavigationLink(destination: FavoritePageView()){
                            ZStack {
                                Rectangle()
                                    .frame(width: 168, height: 38)
                                    .foregroundColor(.clear)
                                Text("Tempat Favorite")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(Color("Grey500"))
                            }
                        }
                    }
                }
                .frame(maxWidth: screenWidth)
                
                ScrollView {
                    VStack (spacing: 20) {
                        //TODO: Ganti viewModel nya jangan viewModel.cafes, ganti sesuai database
                        if !viewModel.cafes.isEmpty {
                            //TODO: ganti jadi database cafe yg udah di checkin user (udah pencet tombol klaim reward)
                            //TODO: Ganti viewModel nya jangan viewModel.cafes, ganti sesuai database
                            ForEach(viewModel.cafes) { cafe in
                                RiwayatCardView(cafe: cafe)
                                    .onTapGesture {
                                        openInMaps(cafe: cafe)
                                    }
                            }.frame(maxWidth: .infinity)
                        } else {
                            HStack{
                                Spacer()
                                VStack(alignment: .center, spacing: -5) {
                                    Spacer()
                                    VStack(alignment: .center, spacing: -5) {
                                        Text("Loh, kosong?!")
                                            .font(
                                                Font.custom("Nunito", size: 22)
                                                    .weight(.bold)
                                            )
                                        
                                        
                                        Text("Ayo, kunjungi cafe dan review sekarang!")
                                            .font(
                                                Font.custom("Nunito", size: 22)
                                                    .weight(.regular)
                                            )
                                            .frame(width: 280, height: 100, alignment: .center)
                                            .multilineTextAlignment(.center)
                                    }
                                    
                                    Image("EmptyStateRiwayat")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 285, alignment: .center)
                                    
                                    
                                    Spacer()
                                }
                                .padding(.top, 40)
                                
                                
                                Spacer()
                            }
                        }
                    }
                }
                ZStack{
                    Rectangle()
                        .frame(width: .infinity, height: 83)
                        .foregroundColor(.white)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    HStack(spacing: 83){
                        
                        NavigationLink(destination: PageExplore(reviews: exampleReviews)){
                            ZStack {
                                
                                VStack (spacing: 5){
                                    Image("Eksplor")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    
                                    Text("Eksplor")
                                        .font(.system(size: 13))
                                        .foregroundColor(.grey999)
                                        .background(Color.clear)
                                }
                                
                            }
                            
                        }
                        
                        NavigationLink {
                            AktivitasPageView()
                        } label: {
                            ZStack {
                                VStack (spacing: 5){
                                    Image("AktivitasBiru")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    
                                    Text("Aktivitas")
                                        .font(.system(size: 13))
                                        .foregroundColor(.primaryBase)
                                        .background(Color.clear)
                                }
                                
                            }
                        }
                        
                        
                        NavigationLink {
                            LevelProfile()
                        } label: {
                            ZStack {
                                VStack (spacing: 5){
                                    Image("Profil")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                    
                                    Text("Profil")
                                        .font(.system(size: 13))
                                        .foregroundColor(.grey999)
                                        .background(Color.clear)
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                viewModel.requestLocationPermission()
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    
    private func openInMaps(cafe: ListCafe) {
        let placemark = MKPlacemark(coordinate: cafe.coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = cafe.name
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    AktivitasPageView()
}

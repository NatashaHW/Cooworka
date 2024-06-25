//model data
import Foundation
import CoreLocation

//TODO: ini kan variabel cuman untuk search aja, tapi hubungin sama database bagian ratingnya, trus kalau di select baru save ke database cafe
struct SearchCafe: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: String
    var rating: Double
    var totalRatings: Int
    var openHours: String
    var distance: Double
    var wifi: String
    var powerOutlet: Int
}

//search cafe view
import SwiftUI
import MapKit

struct SearchCafeView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var viewModel = SearchViewModel()
    @State private var searchQuery = ""
    
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    let reviews: [ReviewCafe]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack(spacing: 20) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26))
                        .foregroundColor(Color("PrimaryBase"))
                }
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color("GreyTertiary"))
                    
                    // Search Bar
                    TextField("Temukan tempat WFC", text: $searchQuery, onCommit: {
                        viewModel.searchLocations(query: searchQuery)
                    })
                    .onChange(of: searchQuery) { newQuery in
                        viewModel.searchLocations(query: newQuery)
                    }
                    
                }
                .padding()
                .background(Color("GreyLight"))
                .cornerRadius(30)
                .frame(width: 240)
                
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .font(.system(size: 28))
                    .foregroundColor(Color("PrimaryBase"))
                    .background(
                        Color("GreyLight")
                            .frame(width: 50, height: 50)
                            .cornerRadius(30)
                    )
                
            }
            .padding(.leading, 27)
            
            // Search Results
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if !viewModel.searchCafeResults.isEmpty {
                        Section(header:
                                    Text("Hasil Pencarian")
                            .font(
                                Font.custom("Nunito", size: 26)
                                    .weight(.semibold)
                            )
                                
                                .padding(.leading, 22)
                                .padding(.bottom, -5)
                        ) {
                            VStack(spacing: 10) {
                                ForEach(viewModel.searchCafeResults) { location in
                                    DetailSearchView(cafe: location, reviews: reviews)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                    }
                    
//                    if !viewModel.nearbyCafeLocations.isEmpty {
//                        Section(header:
//                                    Text("Rekomendasi Cafe Terdekat")
//                            .font(
//                                Font.custom("Nunito", size: 22)
//                                    .weight(.semibold)
//                            )
//
//                                .padding(.leading, 22)
//                                .padding(.bottom, -5)
//                        ) {
//                            VStack(spacing: 10) {
//                                ForEach(viewModel.nearbyCafeLocations) { location in
//                                    DetailSearchView(cafe: location, reviews: reviews)
//                                        .frame(maxWidth: .infinity)
//                                }
//                            }
//                        }
//                    }
                }
                
            }
        }
        .padding(.top, 15)
        .onAppear {
            viewModel.requestCurrentLocation()
        }
        .navigationBarBackButtonHidden()
    }
}

import SwiftUI

struct SearchCafeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchCafeView(reviews: exampleReviews)
        }
    }
}


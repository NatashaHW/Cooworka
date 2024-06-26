//
//  MainTabView.swift
//  Cooworka
//
//  Created by Natasha Hartanti Winata on 25/06/24.
//

import SwiftUI

struct MainTabView: View {
//    let labels: [String] = ["Eksplor", "Aktivitas", "Profil"]
//    let imageBlues: [String] = ["EksplorBiru", "AktivitasBiru", "ProfilBiru"]
    @State var selectedLabel = "Eksplor" ?? nil
    let reviews: [ReviewCafe]
    var isSelected: Bool = true
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Rectangle()
                    .frame(width: .infinity, height: 83)
                    .foregroundColor(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                HStack{
                    NavigationLink {
                        PageExplore(reviews: reviews)
                    } label: {
                        TabViewComponent(label: "Eksplor", isSelected: selectedLabel == "Eksplor", imageBlue: "EksplorBiru", action: {
                            handleSelection("Eksplor")
                        })
                    }
                    
                    Spacer()
                    
                    NavigationLink {
                        AktivitasPageView()
                    } label: {
                        TabViewComponent(label: "Aktivitas", isSelected: selectedLabel == "Aktivitas", imageBlue: "AktivitasBiru", action: {
                            handleSelection("Aktivitas")
                        })
                    }
                    
                    Spacer()

                    NavigationLink {
                        LevelProfile()
                    } label: {
                        TabViewComponent(label: "Profil", isSelected: selectedLabel == "Profil", imageBlue: "ProfilBiru", action: {
                            handleSelection("Profil")
                        })
                    }
                    
                }

                    }

        }
    }
    private func handleSelection(_ label: String) {
        if selectedLabel != label {
            selectedLabel = label
            print("Selected label: \(label)")
            
//            switch selectedLabel {
//            case "Eksplor":
//                
//                NavigationLink(destination: {PageExplore(reviews: reviews)}, label: {})
//            case "Aktivitas":
//                NavigationLink(destination: {AktivitasPageView()}, label: {})
//            case "Profil":
//                NavigationLink(destination: {LevelProfile()}, label: {})
//            default:
//               
//                NavigationLink(destination: {PageExplore(reviews: reviews)}, label: {})
//            }
            
            }
        }
    }


#Preview {
   MainTabView(reviews: exampleReviews)
}

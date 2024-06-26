//
//  MainTabView.swift
//  Cooworka
//
//  Created by Natasha Hartanti Winata on 25/06/24.
//

import SwiftUI

struct MainTabView: View {
    init() {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.primaryBase
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.primaryBase]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    
    var body: some View {
        var firstName = "Natasha"

        TabView {

            PageExplore(reviews: exampleReviews, firstName: firstName)
                .tabItem {
                    Label("Eksplor", systemImage: "magnifyingglass")
                        
                        
                }
            
            AktivitasPageView()
                .tabItem {
                    Label("Aktivitas", systemImage: "list.bullet")
                }
            
//            ReviewPageInitial()
//                .tabItem {
//                    Label("Leaderboard", systemImage: "star")
//                }
            
            LevelProfile(reviews: exampleReviews)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        
    }
}

#Preview {
    MainTabView()
}

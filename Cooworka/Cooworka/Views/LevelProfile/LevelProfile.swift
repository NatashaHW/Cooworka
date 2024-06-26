//
//  LevelProfile.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 25/06/24.
//

import SwiftUI

extension AnyTransition {
    static var pushFromBottom: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.move(edge: .bottom).combined(with: .opacity),
            removal: AnyTransition.move(edge: .top).combined(with: .opacity)
        )
    }
    
    static var pushFromTop: AnyTransition {
        AnyTransition.asymmetric(
            insertion: AnyTransition.move(edge: .top).combined(with: .opacity),
            removal: AnyTransition.move(edge: .bottom).combined(with: .opacity)
        )
    }
}

struct LevelProfile: View { //TODO: animation belum smooth
    @State private var showProfile = false
    
    let reviews: [ReviewCafe]
    
    var body: some View {
        ZStack {
            if showProfile {
                Profile(action: {
                    withAnimation {
                        showProfile.toggle()
                    }
                }, reviews: reviews)
                .transition(.pushFromBottom)
            } else {
                LevelView {
                    withAnimation {
                        showProfile.toggle()
                    }
                }
                .transition(.pushFromTop)
            }
        }
        .animation(.easeInOut, value: showProfile)
    }
}

#Preview {
    LevelProfile(reviews: exampleReviews)
}

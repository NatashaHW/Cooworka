//
//  TabViewComponent.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 26/06/24.
//

import SwiftUI

struct TabViewComponent: View {
    var label: String
    var isSelected: Bool
    var imageBlue: String
    var action: () -> Void
    
    var body: some View {
        VStack (spacing: 5){
            Image(isSelected ? imageBlue : label)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
               
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(isSelected ? .primaryBase : .grey999 )
                .background(Color.clear)
        }
        .onTapGesture {
            
            action()
            
  
        }
    }
}

#Preview {
    TabViewComponent(label: "Eksplor", isSelected: true, imageBlue: "EksplorBiru", action: {})
}

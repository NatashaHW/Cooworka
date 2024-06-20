//
//  preview.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct PreviewYesNoButton: View {
    @Binding var ada: Bool
    @State  var gakAda: Bool = false
    @State var title: String
    let onRatingChange: () -> Void
    @State private var hasChanged: Bool = false
    
    var body: some View {
        HStack{
            Text("\(title)")
                .font(.subheadline)
                .fontWeight(.regular)
            
            Spacer()
            HStack{
                YesOrNoRating(label: "Ada", isSelected: $ada)
                
                YesOrNoRating(label: "Gak Ada", isSelected: $gakAda)
            }
            .onChange(of: ada) { newValue in
                if newValue {
                    gakAda = false
                    if !hasChanged {
                        onRatingChange()
                        hasChanged = true
                    }
                }
            }
            .onChange(of: gakAda) { newValue in
                if newValue {
                    ada = false
                    if !hasChanged {
                        onRatingChange()
                        hasChanged = true
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    PreviewYesNoButton(ada: .constant(true), title: "Makanan berat"){
        
    }
}

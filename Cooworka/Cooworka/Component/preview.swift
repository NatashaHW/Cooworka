//
//  preview.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 20/06/24.
//

import SwiftUI

struct previewRadioButton: View {
    @State private var adaMakananBerat: Bool = false
    @State private var gakAdaMakananBerat: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                YesOrNoRating(label: "Ada", isSelected: $adaMakananBerat)
                
                YesOrNoRating(label: "Gak Ada", isSelected: $gakAdaMakananBerat)
                
            }
            .onChange(of: adaMakananBerat) { newValue in
                if newValue {
                    gakAdaMakananBerat = false
                }
            }
            .onChange(of: gakAdaMakananBerat) { newValue in
                if newValue {
                    adaMakananBerat = false
                }
            }
            Text("ada makanan berat is: \(adaMakananBerat.description)")
        }
    }
}

#Preview {
    previewRadioButton()
}

//
//  KetersediaanParkir.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 21/06/24.
//

import SwiftUI

struct KetersediaanParkir: View {
    @Binding var isMotorParking: Bool
    @Binding var isMobilParking: Bool
    @State var title: String
    let onRatingChange: () -> Void
    @State private var hasChanged: Bool = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 3){
                Text("\(title)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                
                
                Text("(Bisa pilih keduanya)")
                    .font(.system(size: 10))
                    .foregroundColor(.description)
            }
            
            Spacer()
            
            HStack{
                KetersediaanParkirElement(label: "Motor", isSelected: $isMotorParking)
                
                KetersediaanParkirElement(label: "Mobil", isSelected: $isMobilParking)
                
            }
            .onChange(of: isMotorParking) { newValue in

                    if !hasChanged {
                        onRatingChange()
                        hasChanged = true
                    }
            }
            .onChange(of: isMobilParking) { newValue in

                    if !hasChanged {
                        onRatingChange()
                        hasChanged = true
                    }
            }
        }
        .padding(.vertical, 3)
    }
}

#Preview {
    KetersediaanParkir(isMotorParking: .constant(true), isMobilParking: .constant(false), title: "Ketersediaan parkir", onRatingChange: {})
}

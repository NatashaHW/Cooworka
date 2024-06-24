//
//  FotoElement.swift
//  Cooworka
//
//  Created by Lucinda Artahni on 21/06/24.
//

import SwiftUI

struct FotoElement: View {
    @State private var isShowingPhotoPicker = false
    @State private var selectedImages: [UIImage] = []
    let openGallery: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            Text("Foto")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("Share foto-foto kamu di sini daripada tertimbun di galeri.")
                .font(.system(size: 11))
                .foregroundColor(.description)
            
            Button(action: {
                openGallery()
            }, label: {
                HStack {
                    Image("Add photo")
                        .resizable()
                        .foregroundColor(.black)
                        .frame(width: 24, height: 24)
                        .aspectRatio(contentMode: .fit)
                    
                    
                    Text("Add photos & videos")
                        .foregroundColor(.black)
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                }
            })
            .frame(width: 344, height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.primaryBase, lineWidth: 3)
            )
            .cornerRadius(12)
            .padding(.top, 5)
            
            
            
            
        }
        
    }
}

#Preview {
    FotoElement(openGallery: {})
}

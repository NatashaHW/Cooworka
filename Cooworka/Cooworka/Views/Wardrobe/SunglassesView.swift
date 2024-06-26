import SwiftUI

struct SunglassesView: View {
    @Binding var selectedImage: String?

    let sunglasses = [
        "NoSunglasses",
        "Kacamata1",
        "Kacamata2",
        "Kacamata3",
    ]

    var body: some View {
        
        VStack {
            Spacer()
            
            if let selectedImage = selectedImage, selectedImage != "NoSunglasses" {
                Image(selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 190, maxHeight: .infinity)
                    .padding()
                    .padding(.bottom, 190)
            }
            
            ZStack(alignment: .top) {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 393, height: 319)
                    .cornerRadius(32)
                
                VStack(spacing: 10) {
                        HStack(spacing: 10) {
                            ZStack {
                                Rectangle()
                                    .frame(width: 80, height: 42)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("PrimaryBase"), lineWidth: 3)
                                    )
                                Image("KacamataHeader")
                                    .frame(maxHeight: 50)
                                    .padding()
                            }
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 80, height: 42)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color("Grey300"), lineWidth: 2)
                                    )
                                Image("TopiHeader")
                                    .frame(maxHeight: 50)
                                    .padding()
                            }
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 80, height: 42)
                                    .foregroundColor(Color("Grey200"))
                                    .cornerRadius(20)
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Grey500"))
                                    .padding()
                            }
                            
                            ZStack {
                                Rectangle()
                                    .frame(width: 80, height: 42)
                                    .foregroundColor(Color("Grey200"))
                                    .cornerRadius(20)
                                Image(systemName: "lock.fill")
                                    .font(.system(size: 18))
                                    .foregroundColor(Color("Grey500"))
                                    .padding()
                            }
                        }
                        
                    
                    HStack(spacing: 10) {
                        ForEach(sunglasses, id: \.self) { image in
                            Button(action: {
                                selectedImage = image
                            }) {
                                ZStack {
                                    Rectangle()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
                                        .shadow(color: selectedImage == image ? Color("PrimaryBase") : Color("Shadow"), radius: 5)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(selectedImage == image ? Color("PrimaryBase") : Color.clear, lineWidth: 4)
                                        )
                                    
                                    if image == "NoSunglasses" {
                                        Image(image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxHeight: 30)
                                            .padding()
                                        
                                    } else {
                                        Image(image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxHeight: 50)
                                            .padding()
                                    }
                                }
                                .frame(width: 80, height: 80)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .padding()
    }
}

struct SunglassesView_Previews: PreviewProvider {
    static var previews: some View {
        SunglassesView(selectedImage: .constant("NoSunglasses"))
    }
}

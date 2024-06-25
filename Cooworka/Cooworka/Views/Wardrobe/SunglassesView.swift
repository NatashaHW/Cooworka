import SwiftUI

struct SunglassesView: View {
    @State private var selectedImage: String? = nil

    let sunglasses = [
        "NoSunglasses",
        "Kacamata1",
        "Kacamata2",
        "Kacamata3",
    ]

    var body: some View {
        VStack {
            if let selectedImage = selectedImage {
                Image(selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .padding(.bottom, 150)
            }
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 393, height: 319)
                    .cornerRadius(32)
                
                
                HStack {
                    ForEach(sunglasses, id: \.self) { image in
                        Button(action: {
                            selectedImage = image
                        }) {
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 50)
                                .padding()
                        }
                    }
                }
            }
            
        }
        .padding()
    }
}

struct SunglassesView_Previews: PreviewProvider {
    static var previews: some View {
        SunglassesView()
    }
}

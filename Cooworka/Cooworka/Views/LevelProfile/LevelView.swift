import SwiftUI

struct LevelView: View {
    @State var descPangkat = "Pangkat kamu saat ini adalah"
    @State var label = "Budak Jompo"
    
    
    @State var currentLevel = 1
    
    let levels = Levels
    
    var action: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: .infinity, height: .infinity)
                        .foregroundColor(.backgroundProfile)
                    
                    Circle()
                        .scale(2)
                        .offset(y: 425)
                        .foregroundColor(.lightBlueForPopUp)
                    
                    
                    ZStack(alignment: .topTrailing) {
                        VStack {
                            Spacer()
                                .frame(height: 75)
                            
                            VStack(spacing: 10) {
                                VStack {
                                    Text(descPangkat)
                                        .font(.headline)
                                        .fontWeight(.regular)
                                        .padding(.bottom, 1)
                                    
                                    
                                    Text(levels[currentLevel - 1].levelName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                }
                                
                                ZStack {
                                    RoundedRectangle(cornerRadius: 30)
                                        .frame(width: 112, height: 48)
                                        .foregroundColor(.white)
                                        .shadow(color: Color("PrimaryBase").opacity(0.3), radius: 4, x: 0, y: 5)
                                    
                                    Text("890 XP") //TODO: ganti xp dari data
                                    //                                .font(.title3)
                                        .font(.system(size: 19))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    
                                }
                                .padding(.bottom, 20)
                            }
                            
                            ZStack{
                                HStack(spacing: 150){
                                    Button(action: {
                                        if currentLevel > 1 {
                                            currentLevel -= 1
                                        }
                                    }, label: {
                                        Image(systemName: "chevron.left")
                                            .resizable()
                                            .frame(width: 8, height: 13)
                                            .foregroundColor(currentLevel == 1 ? .gray : .black)
                                    })
                                    
                                    Button(action: {
                                        if currentLevel < 8 {
                                            currentLevel += 1
                                        }
                                    }, label: {
                                        Image(systemName: "chevron.right")
                                            .resizable()
                                            .frame(width: 8, height: 13)
                                            .foregroundColor(currentLevel == 8 ? .gray : .black)
                                    })
                                    
                                    
                                }
                                .zIndex(1)
                                .offset(y: 100)
                                
                                ScrollViewReader { proxy in
                                    ScrollView(.horizontal){
                                        VStack (alignment: .leading){
                                            HStack(spacing: 75) {
                                                ForEach(levels, id: \.noLevel) { level in
                                                    Image(level.imageName)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 175)
                                                        .scaleEffect(currentLevel == level.noLevel ? 1.1 : 0.9)
                                                    
                                                }
                                            }
                                            .padding(.leading, 110)
                                            .padding(.bottom, 20)
                                            .padding(.top, 20)
                                            
                                            
                                            
                                            
                                            ZStack (alignment: .leading){
                                                RoundedRectangle(cornerRadius: 25)
                                                    .frame(width: 2070/170, height: 10) //bagi point xp
                                                    .padding()
                                                    .zIndex(0.5)
                                                    .overlay(
                                                        LinearGradient(gradient: Gradient(colors: [.lightYellow, .darkYellow]), startPoint: .leading, endPoint: .trailing))
                                                    .mask(RoundedRectangle(cornerRadius: 25)
                                                        .frame(width: 2070/170, height: 10))
                                                
                                                
                                                
                                                RoundedRectangle(cornerRadius: 25)
                                                    .frame(width: 2070, height: 14)
                                                    .padding(.horizontal, 15)
                                                    .foregroundColor(.white)
                                                
                                                
                                                HStack(spacing: 205){
                                                    ForEach(levels, id: \.noLevel){ level in
                                                        ZStack {
                                                            Image("PointBorder")
                                                                .resizable()
                                                                .frame(width: 46, height: 46)
                                                            
                                                            
                                                            Text("\(level.pointsToUnlock) XP")
                                                                .multilineTextAlignment(.center)
                                                                .frame(width: 40)
                                                                .font(.system(size: 7, weight: .regular))
                                                                .offset(y: 2)
                                                        }
                                                        
                                                    }
                                                    
                                                }
                                                .padding(.leading, 178)
                                                .padding(.trailing, 178)
                                                .zIndex(1)
                                            }
                                        }
                                    }
                                    .disabled(true)
                                    .onChange(of: currentLevel) { newValue in
                                        withAnimation {
                                            proxy.scrollTo(newValue, anchor: .center)
                                        }
                                    }
                                }
                            }
                            
                            Text("Kumpulkan 110 XP lagi untuk naik pangkat!")
                                .font(.subheadline)
                                .fontWeight(.regular)
                            
                            HStack {
                                Text("Kunjungi cafe dan tulis review ")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                
                                Text("sekarang.")
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                                        //TODO: LANJUT KE PAGE MANA?
                                        
                                    }
                                    .padding(.leading, -9)
                            }
                            .padding(.bottom, 20)
                            
                            ReviewHelpfulStat()
                            
                            VStack(spacing: 5){ //TODO: animation transition scroll down ke page selanjutnya
                                Text("Scroll")
                                    .fontWeight(.regular)
                                    .font(.caption)
                                
                                
                                Image(systemName: "chevron.down")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 22)
                            }
                            .padding(.top, 5)
                            .gesture(
                                DragGesture()
                                    .onEnded { gesture in
                                        withAnimation {
                                            if gesture.translation.height < -25 {
                                                print("Swiped up!")
                                                action()
                                            }
                                        }
                                    }
                            )
                            
                            
                            Spacer()
                            
                        }
                        .padding(.top, 20)
                        
                        NavigationLink(destination: WardrobeView()) {
                            Image("IconWardrobe")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.top, 60)
                                .padding(.trailing, 20)
                        }
                    }
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
            }
        }
    }
}

#Preview {
    LevelView( action: {})
}

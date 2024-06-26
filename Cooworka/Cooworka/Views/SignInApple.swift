//
//  ContentView.swift
//  Sign In With Apple
//
//  Created by Natasha Hartanti Winata on 13/06/24.
//
import AuthenticationServices
import SwiftUI

struct SignInApple: View {
    @Environment(\.colorScheme) var colorScheme
    
    //Create environment object to hold this data
    //Cache User Info
    @AppStorage("userId") var userId: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    
    private var isSignedIn: Bool {
        !userId.isEmpty
    }
    
    //    @State private var isSignedIn = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if !isSignedIn {
                    
                    ZStack(alignment: .bottom) {
                        
                        ZStack(alignment: .top) {
                            VStack {
                                Image("PageDaftar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .ignoresSafeArea()
                                    .frame(width: 419, height: 694)
                                    .padding(.top, -100)
                                
                                Spacer()
                            }
                            
                            Text("Buruan daftar sekarang !\nTemukan tempat WFC\nfavorit-mu")
                                .font(
                                    Font.custom("Nunito", size: 16)
                                        .weight(.bold)
                                )
                                .frame(width: 280, height: 100, alignment: .center)
                                .multilineTextAlignment(.center)
                                .padding(.top, 125)
                                .padding(.leading, -55)
                        }
                        
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 393, height: 202)
                                .cornerRadius(30)
                            
                            VStack(alignment: .leading, spacing: 22) {
                                Text("Daftar")
                                    .font(
                                        Font.custom("Nunito", size: 26)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(.black)
                                    .padding(.leading, 50)
                                
                                SignInButtonView()
                                    .padding(.horizontal, 35)
                            }
                            
                        }
                    }
                }
                else {
                    
//                    PageExplore(reviews: exampleReviews, firstName: firstName)
                    
                    //Already Signed in
//                    MainTabView(selectedLabel: <#Binding<String?>#>)
                    PageExplore(reviews: exampleReviews)
                    
                    
                }
            }
        }
    }
}

struct SignInButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    
    //Create environment object to hold this data
    //Cache User Info
    @AppStorage("userId") var userId: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    
    var body: some View {
        SignInWithAppleButton(.continue) { request in
            // Handling request
            request.requestedScopes = [.email, .fullName]
            
        } onCompletion: { result in
            
            switch result {
            case .success(let auth):
                switch auth.credential {
                case let credential as ASAuthorizationAppleIDCredential:
                    //User ID -> dapet walaupun user hapus app
                    let userId = credential.user
                    
                    // make info about the user
                    //User Info -> bisa diakses setelah dapat userID
                    //Disimpen di user defaults bisa di encrypt -> save it in the user's keychain for better security
                    let email = credential.email
                    let firstName = credential.fullName?.givenName
                    let lastName = credential.fullName?.familyName
                    
                    self.userId = userId
                    self.email = email ?? ""
                    self.firstName = firstName ?? ""
                    self.lastName = lastName ?? ""
                    
                    //tambahin error case kalau email, dll itu empty jadi pake guard
                    
                    print(userId)
                    print(email ?? "")
                    print(firstName ?? "")
                    print(lastName ?? "")
                    
                    
                    break
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
        .signInWithAppleButtonStyle(
            colorScheme == .dark ? .white : .black
        )
        .frame(height: 50)
        .padding()
        .cornerRadius(8)
    }
}

#Preview {
    SignInApple()
}

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
                    SignInButtonView()
                }
                else {
                    
//                    PageExplore(reviews: exampleReviews, firstName: firstName)
                    //Signed in
                    MainTabView()
                    
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

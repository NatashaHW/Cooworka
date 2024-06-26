import SwiftUI

struct ReviewExtra: View {
    @Binding var reviewText: String
    let updatePoint: () -> Void
    let deductPoint: () -> Void
    @State private var filled: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Review Extra")
                .font(.subheadline)
                .fontWeight(.bold)
            
            Text("Ada yang ingin kamu jelaskan lebih lanjut? Tulis di sini!")
                .font(.system(size: 11))
                .foregroundColor(.description)
                .padding(.bottom, 3)
            
            TextEditor(text: $reviewText)
                .frame(width: 344, height: 132)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.textboxGrey, lineWidth: 1)
                )
                .font(.system(size: 13))
                .multilineTextAlignment(.leading)
                .disableAutocorrection(true)
                .autocapitalization(.sentences)
                .onChange(of: reviewText) { newValue in
                    if !reviewText.isEmpty && filled == false {
                        updatePoint()
                        filled = true
                    }
                    if reviewText.isEmpty && filled == true {
                        deductPoint()
                        filled = false
                    }
                }
        }
        .contentShape(Rectangle())  // To make the entire VStack tappable
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ReviewExtra(reviewText: .constant("hahaha"), updatePoint: {}, deductPoint: {})
}

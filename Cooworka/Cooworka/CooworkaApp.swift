import SwiftUI

@main
struct CooworkaApp: App {
    var body: some Scene {
        WindowGroup {
            PageReview(reviews: exampleReviews)
        }
    }
}

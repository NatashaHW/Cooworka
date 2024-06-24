import SwiftUI

@main
struct CooworkaApp: App {
    var body: some Scene {
        WindowGroup {
            PageExplore(reviews: exampleReviews)
        }
    }
}

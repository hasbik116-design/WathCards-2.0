import SwiftUI

@main
struct WatchCardsApp: App {
    @StateObject private var store = DeckStore()

    var body: some Scene {
        WindowGroup {
            DeckListView()
                .environmentObject(store)
        }
    }
}

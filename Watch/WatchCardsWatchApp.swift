import SwiftUI

@main
struct WatchCardsWatchApp: App {
    @StateObject private var store = WatchDeckStore()
    var body: some Scene {
        WindowGroup { WatchDeckListView().environmentObject(store) }
    }
}

import Foundation
import WatchConnectivity

final class WatchDeckStore: NSObject, ObservableObject, WCSessionDelegate {
    @Published private(set) var decks: [CardDeck] = []
    private let storageKey = "watchcards.cached.payload"

    override init() {
        super.init()
        loadCached()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    private func loadCached() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let payload = try? JSONDecoder().decode(WatchSyncPayload.self, from: data) else { return }
        decks = payload.decks
    }

    private func accept(_ data: Data) {
        guard let payload = try? JSONDecoder().decode(WatchSyncPayload.self, from: data) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
        DispatchQueue.main.async { self.decks = payload.decks }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let data = session.receivedApplicationContext["watchcards"] as? Data { accept(data) }
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let data = applicationContext["watchcards"] as? Data { accept(data) }
    }
}

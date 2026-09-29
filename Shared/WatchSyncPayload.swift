import Foundation

struct WatchSyncPayload: Codable {
    let version: Int
    let updatedAt: Date
    let decks: [CardDeck]
}

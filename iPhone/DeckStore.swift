import Foundation
import Combine

final class DeckStore: ObservableObject {
    @Published var decks: [CardDeck] = [
        CardDeck(title: "БиОТ", icon: "cross.case.fill", cards: [
            FlashCard(question: "Минимальный возраст работника?", answer: "18 лет"),
            FlashCard(question: "Периодичность обучения БиОТ?", answer: "1 раз в 3 года"),
            FlashCard(question: "Когда сообщить о несчастном случае?", answer: "Немедленно руководителю")
        ]),
        CardDeck(title: "ПТЭ", icon: "tram.fill", cards: [
            FlashCard(question: "Что означает красный сигнал?", answer: "Стой! Движение запрещено")
        ])
    ] {
        didSet { WatchSyncManager.shared.sync(decks: decks) }
    }

    init() {
        WatchSyncManager.shared.activate()
        WatchSyncManager.shared.sync(decks: decks)
    }

    func addDeck(title: String) { decks.append(CardDeck(title: title.isEmpty ? "Новый набор" : title)) }
    func addCard(to deckID: UUID, question: String, answer: String) {
        guard let index = decks.firstIndex(where: { $0.id == deckID }) else { return }
        decks[index].cards.append(FlashCard(question: question, answer: answer))
    }
    func addCards(to deckID: UUID, cards: [FlashCard]) {
        guard let index = decks.firstIndex(where: { $0.id == deckID }) else { return }
        decks[index].cards.append(contentsOf: cards)
    }
    func mark(deckID: UUID, cardID: UUID, needsReview: Bool) {
        guard let d = decks.firstIndex(where: { $0.id == deckID }), let c = decks[d].cards.firstIndex(where: { $0.id == cardID }) else { return }
        decks[d].cards[c].needsReview = needsReview
    }
}

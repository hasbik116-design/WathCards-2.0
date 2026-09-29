import SwiftUI

struct StudyView: View {
    @EnvironmentObject var store: DeckStore
    let deckID: UUID
    @State private var index = 0
    @State private var reveal = false

    var deck: CardDeck? { store.decks.first(where: { $0.id == deckID }) }

    var body: some View {
        if let deck, !deck.cards.isEmpty {
            let card = deck.cards[min(index, deck.cards.count - 1)]
            VStack(spacing: 24) {
                Text("\(index + 1) / \(deck.cards.count)").foregroundStyle(.secondary)
                Spacer()
                Text(card.question).font(.title2.bold()).multilineTextAlignment(.center)
                if reveal { Text(card.answer).font(.title3).multilineTextAlignment(.center).transition(.opacity) }
                Spacer()
                if reveal {
                    HStack {
                        Button("✕ Повторить") { rate(card, true, deck.cards.count) }.buttonStyle(.bordered)
                        Button("✓ Знаю") { rate(card, false, deck.cards.count) }.buttonStyle(.borderedProminent)
                    }
                } else {
                    Button("Показать ответ") { withAnimation { reveal = true } }.buttonStyle(.borderedProminent)
                }
            }.padding().navigationTitle(deck.title)
        } else { ContentUnavailableView("Нет карточек", systemImage: "rectangle.stack") }
    }

    private func rate(_ card: FlashCard, _ needsReview: Bool, _ count: Int) {
        store.mark(deckID: deckID, cardID: card.id, needsReview: needsReview)
        reveal = false
        index = (index + 1) % count
    }
}

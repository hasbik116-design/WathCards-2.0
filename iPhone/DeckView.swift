import SwiftUI

struct DeckView: View {
    @EnvironmentObject var store: DeckStore
    let deckID: UUID
    @State private var showAdd = false
    @State private var showImport = false

    var deck: CardDeck? { store.decks.first(where: { $0.id == deckID }) }

    var body: some View {
        Group {
            if let deck {
                List {
                    NavigationLink("Начать повторение") { StudyView(deckID: deckID) }
                        .font(.headline)
                    ForEach(deck.cards) { card in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(card.question).font(.headline)
                            Text(card.answer).foregroundStyle(.secondary)
                            if card.needsReview { Label("Повторить", systemImage: "arrow.clockwise") .font(.caption) }
                        }.padding(.vertical, 3)
                    }
                }
                .navigationTitle(deck.title)
                .toolbar {
                    Menu {
                        Button { showAdd = true } label: { Label("Добавить вручную", systemImage: "plus") }
                        Button { showImport = true } label: { Label("Текст → карточки", systemImage: "sparkles") }
                    } label: { Image(systemName: "plus") }
                }
                .sheet(isPresented: $showAdd) { AddCardView(deckID: deckID) }
                .sheet(isPresented: $showImport) { ImportTextView(deckID: deckID) }
            } else { ContentUnavailableView("Набор не найден", systemImage: "rectangle.stack") }
        }
    }
}

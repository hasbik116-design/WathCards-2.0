import SwiftUI

struct DeckListView: View {
    @EnvironmentObject var store: DeckStore
    @State private var showCreate = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(store.decks) { deck in
                    NavigationLink {
                        DeckView(deckID: deck.id)
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: deck.icon)
                                .font(.title2)
                                .frame(width: 38, height: 38)
                            VStack(alignment: .leading, spacing: 3) {
                                Text(deck.title).font(.headline)
                                Text("\(deck.cards.count) карточек")
                                    .font(.caption).foregroundStyle(.secondary)
                            }
                        }.padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("WatchCards")
            .toolbar {
                Button { showCreate = true } label: { Image(systemName: "plus") }
            }
            .sheet(isPresented: $showCreate) { CreateDeckView() }
        }
    }
}

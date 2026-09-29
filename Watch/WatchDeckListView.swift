import SwiftUI

struct WatchDeckListView: View {
    @EnvironmentObject var store: WatchDeckStore
    var body: some View {
        NavigationStack {
            Group {
                if store.decks.isEmpty {
                    VStack(spacing: 8) {
                        Image(systemName: "iphone.and.arrow.forward")
                        Text("Нет карточек").font(.headline)
                        Text("Открой WatchCards на iPhone для синхронизации.")
                            .font(.caption2).foregroundStyle(.secondary).multilineTextAlignment(.center)
                    }
                } else {
                    List(store.decks) { deck in
                        NavigationLink {
                            WatchStudyView(deck: deck)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(deck.title)
                                Text("\(deck.cards.count) карточек").font(.caption2).foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }.navigationTitle("WatchCards")
        }
    }
}

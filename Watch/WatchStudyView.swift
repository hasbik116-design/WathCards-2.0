import SwiftUI

struct WatchStudyView: View {
    let deck: CardDeck
    @State private var index = 0
    @State private var reveal = false

    var body: some View {
        Group {
            if deck.cards.isEmpty {
                Text("В наборе нет карточек").multilineTextAlignment(.center)
            } else {
                let card = deck.cards[index]
                VStack(spacing: 8) {
                    Text("\(index + 1) / \(deck.cards.count)").font(.caption2).foregroundStyle(.secondary)
                    Spacer()
                    Text(reveal ? card.answer : card.question)
                        .font(reveal ? .headline : .body).multilineTextAlignment(.center)
                    Spacer()
                    if reveal {
                        HStack {
                            Button("✕") { next() }.tint(.orange)
                            Button("✓") { next() }.tint(.green)
                        }
                    } else {
                        Button("Показать") { reveal = true }
                    }
                }.padding(.horizontal, 4)
            }
        }.navigationTitle(deck.title)
    }

    private func next() {
        reveal = false
        index = (index + 1) % deck.cards.count
    }
}

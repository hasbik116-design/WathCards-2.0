import SwiftUI

struct ImportTextView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    let deckID: UUID

    @State private var sourceText = ""
    @State private var preview: [FlashCard] = []

    var body: some View {
        NavigationStack {
            Form {
                Section("Исходный текст") {
                    TextEditor(text: $sourceText)
                        .frame(minHeight: 180)
                    Text("Поддерживаются форматы «Вопрос — ответ», «Термин: определение» и вопрос на одной строке с ответом на следующей.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Section {
                    Button {
                        preview = TextToCardsParser.parse(sourceText)
                    } label: {
                        Label("Превратить в карточки", systemImage: "sparkles")
                    }
                    .disabled(sourceText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                if !preview.isEmpty {
                    Section("Предпросмотр — \(preview.count)") {
                        ForEach(preview) { card in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(card.question).font(.headline)
                                Text(card.answer).foregroundStyle(.secondary)
                            }
                        }
                    }

                    Section {
                        Button("Добавить \(preview.count) карточек") {
                            store.addCards(to: deckID, cards: preview)
                            dismiss()
                        }
                        .fontWeight(.semibold)
                    }
                }
            }
            .navigationTitle("Текст → карточки")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Закрыть") { dismiss() } }
            }
        }
    }
}

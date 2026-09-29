import SwiftUI

struct AddCardView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) var dismiss
    let deckID: UUID
    @State private var question = ""
    @State private var answer = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Вопрос", text: $question, axis: .vertical)
                TextField("Ответ", text: $answer, axis: .vertical)
            }
            .navigationTitle("Новая карточка")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Отмена") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Добавить") { store.addCard(to: deckID, question: question, answer: answer); dismiss() }
                        .disabled(question.isEmpty || answer.isEmpty)
                }
            }
        }
    }
}

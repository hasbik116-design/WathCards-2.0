import SwiftUI

struct CreateDeckView: View {
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) var dismiss
    @State private var title = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Название") { TextField("Например, БиОТ", text: $title) }
                Section("В следующей версии") {
                    Label("Вставить большой текст", systemImage: "doc.text")
                    Label("Загрузить PDF / Word", systemImage: "doc")
                    Label("Сфотографировать документ", systemImage: "camera")
                    Label("ИИ → короткие карточки", systemImage: "sparkles")
                }
            }
            .navigationTitle("Новый набор")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Отмена") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Создать") { store.addDeck(title: title); dismiss() }
                }
            }
        }
    }
}

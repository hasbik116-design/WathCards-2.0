import Foundation

struct FlashCard: Identifiable, Codable, Hashable {
    let id: UUID
    var question: String
    var answer: String
    var needsReview: Bool

    init(id: UUID = UUID(), question: String, answer: String, needsReview: Bool = false) {
        self.id = id
        self.question = question
        self.answer = answer
        self.needsReview = needsReview
    }
}

struct CardDeck: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var icon: String
    var cards: [FlashCard]

    init(id: UUID = UUID(), title: String, icon: String = "rectangle.stack.fill", cards: [FlashCard] = []) {
        self.id = id
        self.title = title
        self.icon = icon
        self.cards = cards
    }
}

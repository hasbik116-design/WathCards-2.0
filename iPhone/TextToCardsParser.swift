import Foundation

enum TextToCardsParser {
    static func parse(_ text: String) -> [FlashCard] {
        let lines = text
            .components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        var cards: [FlashCard] = []
        var pendingQuestion: String?

        for rawLine in lines {
            let line = rawLine.replacingOccurrences(of: #"^\s*\d+[\.)]\s*"#, with: "", options: .regularExpression)

            if let pair = splitPair(line) {
                cards.append(FlashCard(question: compact(pair.0), answer: compact(pair.1)))
                pendingQuestion = nil
                continue
            }

            if line.hasSuffix("?") {
                if let old = pendingQuestion { cards.append(FlashCard(question: compact(old), answer: "Добавьте ответ")) }
                pendingQuestion = line
            } else if let question = pendingQuestion {
                cards.append(FlashCard(question: compact(question), answer: compact(line)))
                pendingQuestion = nil
            } else {
                cards.append(FlashCard(question: "Что нужно запомнить?", answer: compact(line)))
            }
        }

        if let question = pendingQuestion {
            cards.append(FlashCard(question: compact(question), answer: "Добавьте ответ"))
        }

        return Array(cards.prefix(100))
    }

    private static func splitPair(_ line: String) -> (String, String)? {
        for separator in [" — ", " – ", " - ", ": "] {
            let parts = line.components(separatedBy: separator)
            if parts.count >= 2 {
                let left = parts[0].trimmingCharacters(in: .whitespaces)
                let right = parts.dropFirst().joined(separator: separator).trimmingCharacters(in: .whitespaces)
                if !left.isEmpty && !right.isEmpty { return (left, right) }
            }
        }
        return nil
    }

    private static func compact(_ value: String) -> String {
        let normalized = value.replacingOccurrences(of: #"\s+"#, with: " ", options: .regularExpression)
        if normalized.count <= 120 { return normalized }
        return String(normalized.prefix(117)) + "…"
    }
}

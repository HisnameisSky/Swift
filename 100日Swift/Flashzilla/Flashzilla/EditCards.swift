//
//  EditCards.swift
//  Flashzilla
//
//  Created by 澄界 on 2025/07/30.
//

import SwiftUI


struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    var body: some View {
        NavigationStack {
            List {
                Section("Add new cards") {
                    TextField("New Prompt", text: $newPrompt)
                    TextField("New Answer", text: $newAnswer)
                    Button("Add a card", action: addCard)
                }
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .font(.subheadline)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        removeCards(at: indexSet)
                    })
                }
            }
            .navigationTitle("Edit Cards")
            .onAppear(perform: loadData)
            .toolbar {
                Button("Done", action: done)
            }
        }
    }
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    func saveData() {
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: "Cards")
        }
    }
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        cards.insert(Card(prompt: trimmedPrompt, answer: trimmedAnswer), at: 0)
        saveData()
        newPrompt = ""
        newAnswer = ""
    }
    func removeCards(at offsets: IndexSet) {
        cards.remove(atOffsets: offsets)
        saveData()
    }
    func done() {
        dismiss()
    }
}

#Preview {
    EditCards()
}

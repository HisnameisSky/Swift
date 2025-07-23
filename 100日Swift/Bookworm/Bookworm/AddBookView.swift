//
//  AddBookView.swift
//  Bookworm
//
//  Created by 澄界 on 2025/07/24.
//


import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    
    let genres = ["空想物語", "恐怖系", "キッズ", "ミステリー", "文学系", "浪漫系", "スリラー", "SF", "歴史系", "その他"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("本の名前", text: $title)
                    TextField("著作者", text: $author)
                    Picker("書籍の種類", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    
                    
                    Section("日付") {
                        DatePicker("開始日付", selection: $startDate, displayedComponents: [.date])
                        DatePicker("終了日付", selection: $endDate, in: startDate..., displayedComponents: [.date])
                        
                    }
                }
                
                Section("評価を書く") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("保存") {
                        let newBook = Book(title: title, author: author, genre: genre, rating: rating, review: review, startDate: startDate, endDate: endDate)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                }
            }
            .navigationTitle("本の追加")
        }
    }
}

#Preview {
    AddBookView()
}

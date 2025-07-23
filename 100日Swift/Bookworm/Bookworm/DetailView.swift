//
//  DetailView.swift
//  Bookworm
//
//  Created by 澄界 on 2025/07/24.
//

import SwiftData
import SwiftUI

//本一つずつの詳細[DetailView.(_:)]
struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text(book.title)
                    .font(.title)
                    .bold()
                Text(book.author)
                    .font(.title3)
                Text("\(book.startDate.formatted(date: .abbreviated, time: .omitted)) ~ \(book.endDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.callout)
                RatingView(rating: .constant(book.rating))
                    .padding()
                HStack {
                    Text(book.review)
                    Spacer()
                }
            }
            .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        //本の削除
        .alert("本の削除", isPresented: $showingDeleteAlert) {
            Button("削除", role: .destructive, action: deleteBook)
            Button("解消", role: .cancel) { }
        } message: {
            Text("宜しいですか?")
        }
        .toolbar {
            Button("本を削除する", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Title", author: "Test Author", genre: "Mystery", rating: 3, review: "This book was fun enough. But i didn't expect to be fun..", startDate: Date.now, endDate: Date.now)
        return DetailView(book: example)
    } catch {
        return Text("誤作動が発生: プレビューが失敗しました. \(error.localizedDescription)")
    }
}

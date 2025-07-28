//
//  ContentView.swift
//  Bookworm
//
//  Created by 澄界 on 2025/07/24.
//

import SwiftData
import SwiftUI

/*
 読み終えた書籍を記録するアプリでございます
 */
//[ContentView.(_:)]
struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title),
        SortDescriptor(\Book.author)
    ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    NavigationLink(value: book) {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                //削除可能にするプロパティ
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("読書家")
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    //リストの編集ボタン
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("本を加える", systemImage: "plus") {
                        showingAddScreen.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    //書籍の削除機能deleteBooks(at:)
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
}

#Preview {
    ContentView()
}

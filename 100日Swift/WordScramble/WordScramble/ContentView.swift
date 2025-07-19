//
//  ContentView.swift
//  WordScramble
//
//  Created by 澄界 on 2025/07/19.
//

import SwiftUI

//構造体
struct ContentView: View {
    
    //依存される要素の概要欄
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    //Errorの通知専用
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    //英語の言葉における点数判定
    let wordLengthValues = [
        8 : 4000,
        7 : 2500,
        6 : 1600,
        5 : 900,
        4 : 400,
        3 : 100
    ]
    
    //表示される内容
    var body: some View {
        //Stack形式
        NavigationStack {
            List {
                Section {
                    TextField("Enter you word", text: $newWord)
                        .autocapitalization(.none)
                    
                    HStack {
                        Text("Your current score is:")
                        Spacer()
                        Text("\(score)")
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text("Current score:")
                            Spacer()
                            Text("+\(wordLengthValues[word.count] ?? 0)")
                        }
                        //Accessibilityのプロパティ設定
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                        .foregroundStyle(word.count == 8 ? .green : .primary)
                        
                    }
                }
            }
            //Listへの追加
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) { } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        startGame()
                    } label: {
                        Text("New Word")
                    }
                }
            }
        }
    }
    //アプリ機能の概要欄
    func addNewWord() {
        // 小さい文字にして複製している言葉を取り省くようにする
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer != rootWord else {
            wordError(
                title: "Word cannot be the root word",
                message: "Sorry, try something else!"
            )
            return
        }
        
        // 残りのStringが3以上の場合
        guard answer.count >= 3 else {
            wordError(
                title: "Word must be at least 3 letters",
                message: "Sorry, that word is too short!"
            )
            return
        }
        //複製防止
        guard isOriginal(word: answer) else {
            wordError(
                title: "Duplicate word",
                message: "You have already used that word."
            )
            return
        }
        //ライブラリに存在するかどうかを確認
        guard isPossible(word: answer) else {
            wordError(
                title: "Impossible word",
                message: "You can't spell that word from '\(rootWord)'!"
            )
            return
        }
        //認識可能な項とばかどうかを確認
        guard isReal(word: answer) else {
            wordError(
                title: "Unrecognized word",
                message: "You can't just make them up, you know!"
            )
            return
        }
        //アニメーションを追加
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += wordLengthValues[answer.count] ?? 0
        usedWords.insert(answer, at: 0)
        newWord = ""
        
    }
    func startGame() {
        // start.txtのためにURLの内容で探す
        guard let startWordsURL = Bundle.main.url(
            forResource: "start",
            withExtension: "txt"
        )
        else {
            fatalError("Could not load start.txt from bundle.")
        }
        // 2. start.txtをstringに読み込む
        guard let startWords = try? String(
            contentsOf: startWordsURL,
            encoding: .utf8
        )
        else {
            fatalError("Could not load start.txt from bundle.")
        }
        // 3. StringをArrayに分割して行列に並べる
        let allWords = startWords.components(separatedBy: "\n")
        
        // 4. 標準の言葉を任意の言葉かもしくはSilkwormにする
        rootWord = allWords.randomElement() ?? "silkworm"
        
        // もし全部の機能が作動しているならば機能を停止する設定
        score = 0
        usedWords = []
    }
    
    func isOriginal (word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}



#Preview {
    ContentView()
}

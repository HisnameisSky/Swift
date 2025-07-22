//
//  ContentView.swift
//  Navigation
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<1000) { i in
//                NavigationLink("Tap Me") {
//                    DetailView(number: i)
//                }
//            }
//        }
//    }
//}
//
//struct DetailView: View {
//    var number: Int
//
//    var body: some View {
//        Text("Detail View \(number)")
//    }
//
//    init(number: Int) {
//        self.number = number
//        print("Creating detail view \(number)")
//    }
//}

//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                NavigationLink("Select \(i)", value: i)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//        }
//    }
//}

//struct ContentView: View {
//    @State private var path = [Int]()
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            VStack {
//                Button("Show 32") {
//                    path = [32]
//                }
//
//                Button("Show 64") {
//                    path.append(64)
//                }
//
//                Button("Show 32 then 64") {
//                    path = [32, 64]
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//        }
//    }
//}

//struct ContentView: View {
//    @State private var path = NavigationPath()
//
//    var body: some View {
//        NavigationStack(path: $path) {
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Select Number: \(i)", value: i)
//                }
//
//                ForEach(0..<5) { i in
//                    NavigationLink("Select String: \(i)", value: String(i))
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected the number \(selection)")
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("You selected the string \(selection)")
//            }
//            .toolbar {
//                Button("Push 556") {
//                    path.append(556)
//                }
//
//                Button("Push Hello") {
//                    path.append("Hello")
//                }
//            }
//        }
//    }
//}



//-------------------------------
struct DetailView: View {
    var number: Int
    @Binding var path: [Int]

    var body: some View {
        //押せば任意の数字が記載されている画面に移る
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
        //前に数字に戻れるボタン
            .navigationTitle("Number: \(number)")
        
        //最初の画面に戻るボタン
            .toolbar {
                Button("Home") {
                    path.removeAll()
                }
            }
    }
}

struct ContentView: View {
    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $path) {
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $path)
                }
        }
    }
}


////-------------------------------
//@Observable
//class PathStore {
//    var path: NavigationPath {
//        didSet {
//            save()
//        }
//    }

//    private let savePath = L.documentsDirectory.appending(path: "SavedPath")

//    init() {
//        if let data = try? Data(contentsOf: savePath) {
//            if let decoded = try? ONDecoder().decode(NavigationPathodableRepresentation.self, from: data) {
//                path = NavigationPath(decoded)
//                return
//            }
//        }

//        // Still here? Start with an empty path.
//        path = NavigationPath()
//    }

//    func save() {
//        guard let representation = path.codable else { turn }

//        do {
//            let data = try ONEncoder().encode(representation)
//            try data.write(to: savePath)
//        } catch {
//            print("Failed to save navigation data")
//        }
//    }
//}

//struct DetailView: View {
//    var number: Int

//    var body: some View {
//        NavigationLink("Go to Random Number", value: t.random(in: 1...1000))
//            .navigationTitle("Number: \(number)")
//    }
//}

//struct ContentView: View {
//    @State private var pathStore = PathStore()

//    var body: some View {
//        NavigationStack(path: $pathStore.path) {
//            DetailView(number: 0)
//                .navigationDestination(for: Int.self) { i
//                    DetailView(number: i)
//                }
//        }
//    }
//}



//-------------------------------
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<100) { i in
//                Text("Row \(i)")
//            }
//            .navigationTitle("Title goes here")
//            .navigationBarTitleDisplayMode(.inline)
//            //スクロール動作によって題名の色や背景が変わる
//            .toolbarBackground(.blue)
//            .toolbarColorScheme(.dark)
//            // uncomment to hide the navigation bar
//            // .toolbar(.hidden, for: .navigationBar)
//        }
//    }
//}

//-------------------------------
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            Text("Hello, world!")
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Tap Me") {
//                        // button action here
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Tap Me") {
//                        // button action here
//                    }
//                }

//                ToolbarItem(placement: .topBarLeading) {
//                    Button("Or Tap Me") {
//                        // button action here
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItemGroup(placement: .topBarLeading) {
//                    Button("Tap Me") {
//                        // button action here
//                    }

//                    Button("Tap Me 2") {
//                        // button action here
//                    }
//                }
//            }
//        }
//    }
//}



//-------------------------------
//
//struct ContentView: View {
//    @State private var title = "SwiftUI"
//
//    var body: some View {
//        NavigationStack {
//            Text("Hello, world!")
//                .navigationTitle($title)
//            //特殊な.inlineプロパティで本文の編集が可能になる
//                .navigationBarTitleDisplayMode(.inline)
//        }
//    }
//}

#Preview {
    ContentView()
}

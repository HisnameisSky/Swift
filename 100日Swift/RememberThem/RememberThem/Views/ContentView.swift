//
//  ContentView.swift
//  RememberThem
//
//  Created by 澄界 on 2025/07/28.
//

import SwiftUI


//構造体
struct ContentView: View {
    //依存される定義
    @StateObject private var viewModel = ViewModel()
    @State private var isShowingAddView = false
    
    var body: some View {
       
        NavigationView {
            List {
                //項目一つずつの設定
                ForEach(viewModel.people) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        //一つずつの表示情報
                        HStack {
                            person.image?
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                .frame(width: 44, height: 44)
                            
                            Text(person.name)
                        }
                    }
                }
                //保存された項目を左にスワイプして削除したい場合の機能プロパティ
                .onDelete(perform: viewModel.removePerson)
            }
            .navigationBarTitle("Remember Them")
            //＋のボタンを押した時の表示画面
            .sheet(isPresented: $isShowingAddView) {
                AddPersonView()
                    .environmentObject(viewModel)
            }
            .toolbar {
                Button {
                    //人物を追加ボタン
                    isShowingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add a new person")
            }
        }
        
    }
}

#Preview {
    ContentView()
}

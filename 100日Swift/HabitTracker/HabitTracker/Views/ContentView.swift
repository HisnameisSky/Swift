//
//  ContentView.swift
//  HabitTracker
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//[ContentView.()] 
struct ContentView: View {
    
    //依存される変数
    @StateObject var habitVM = HabitViewModel()
    @State private var isShowingAddHabit = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitVM.habits) { habit in
                    NavigationLink {
                        HabitDetailView(
                            habitVM: habitVM,
                            habit: habit
                        )
                    } label: {
                        HStack {
                            Text(habit.title)
                                .font(.headline)
                                .foregroundStyle(habit.color ?? .gray)
                                .lineLimit(2)
                            
                            Spacer(minLength: 40)
                            
                            Text("^[\(habit.completionCount) 完了回数](inflect: true)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 10)
                    }
                }
                //タッチ画面の機能で動くように設定
                .onMove { indexSet, index in
                    habitVM.habits.move(fromOffsets: indexSet, toOffset: index)
                }
                //スワイプ動作で削除するように設定
                .onDelete { offsets in
                    habitVM.habits.remove(atOffsets: offsets)
                }
            }
            //題名
            .navigationTitle("習慣トラッカー")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if habitVM.habits.count > 0 {
                        EditButton()
                    }
                    //「＋」のボタン
                    Button {
                        isShowingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            //「＋」を押した際に現れる画面標識
            .sheet(isPresented: $isShowingAddHabit) {
                AddHabitView(habitVM: habitVM)
            }
        }
    }
}

#Preview {
    ContentView()
}

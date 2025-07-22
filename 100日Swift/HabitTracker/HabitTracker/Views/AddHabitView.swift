//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//[AddHabitView.()]
struct AddHabitView: View {
    
    //依存される変数、別のViewからのも含めて
    @ObservedObject var habitVM: HabitViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var color: Color = .blue
    
    var body: some View {
        NavigationStack {
            //書類式のStack？とも呼べるのか
            Form {
                //一行ずつの見た目と内容
                Section("詳細") {
                    TextField("習慣の題名", text: $title)
                    
                    TextField("習慣の記述", text: $description)
                }
                //家お選びの概要欄
                Section("彩色") {
                    CustomColorPicker(selectedColor: $color)
                }
            }
            //上にある題名
            .navigationTitle("新しい習慣を加える")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //左上に置く
                ToolbarItem(placement: .cancellationAction) {
                    //「解消する」ボタン
                    Button("解消する") {
                        dismiss()
                    }
                }
                //右上にある「保存する」ボタン
                ToolbarItem(placement: .primaryAction) {
                    Button("保存する") {
                        let newHabit = Habit(
                            title: title,
                            description: description,
                            //色選び
                            colorString: Color.habitColors[color, default: nil]
                        )
                        //習慣の追加
                        habitVM.habits.append(newHabit)
                        //その解消方法
                        dismiss()
                    }
                    //弄られないように設定
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddHabitView(habitVM: HabitViewModel())
}



//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//[HabitDetailView.()] 習慣の完了した回数を記録にする画面
struct HabitDetailView: View {
    
    //別のViewの書類からの変数を加える
    @ObservedObject var habitVM: HabitViewModel
    @State var habit: Habit
    
    var body: some View {
        VStack(spacing: 60) {
            VStack(spacing: 20) {
                Text(habit.title)
                    .font(.title2.bold())
                    .foregroundStyle(habit.color ?? .gray)
                
                if !habit.description.isEmpty {
                    Text(habit.description)
                        .font(.title3.italic())
                }
            }
            .multilineTextAlignment(.center)
            .lineLimit(2)
            
            Text("^[\(habit.completionCount) 回数完了](inflect: true)")
                .font(.title.bold())
            
            updateCountButton
            updateCountButton2
        }
        .padding(.horizontal, 40)
    }
    
    private var updateCountButton: some View {
        Button {
            updateHabitCount()
        } label: {
            //真ん中の＋
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(habit.color ?? .gray)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "plus")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
    }
    //回数の更新の機能
    private func updateHabitCount() {
        let index = habitVM.habits.firstIndex(of: habit)
        
        var newHabit = habit
        newHabit.completionCount += 1
        
        guard let index = index else { return }
        
        habitVM.habits[index] = newHabit
        // Update the @State habit to reflect the new one
        habit = newHabit
    }
    //回数の減らす機能の追加
    private var updateCountButton2: some View {
        Button {
            updateHabitCount2()
        } label: {
            //真ん中の＋
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(habit.color ?? .gray)
                    .frame(width: 80, height: 80)
                
                Image(systemName: "minus")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
    }
    //回数の更新の機能
    private func updateHabitCount2() {
        let index = habitVM.habits.firstIndex(of: habit)
        
        var newHabit = habit
        newHabit.completionCount -= 1
        
        guard let index = index else { return }
        
        habitVM.habits[index] = newHabit
        // Update the @State habit to reflect the new one
        habit = newHabit
    }
}
//表示と実例
#Preview {
    HabitDetailView(
        habitVM: HabitViewModel(),
        habit: HabitViewModel.sampleHabits[0]
    )
}

//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by 澄界 on 2025/07/22.
//

import Foundation

//[HabitViewModel.()]
class HabitViewModel: ObservableObject {
    private static let habitsKey = "Habits"
    
    @Published var habits = [Habit]() {
        //別のViewの情報を読み取る
        didSet {
            guard let encodedData = try? JSONEncoder().encode(habits)
            else { return }
            
            UserDefaults.standard.set(encodedData, forKey: Self.habitsKey)
        }
    }
    //classなので手動で動かさなければならない
    init() {
        guard let savedHabits = UserDefaults.standard.data(forKey: Self.habitsKey)
        else { return }
        //別のViewの情報を読み取る
        guard let decodedHabits = try? JSONDecoder().decode(
            [Habit].self,
            from: savedHabits
        ) else { return }
        //継承する設定
        habits = decodedHabits
    }
    //実例
    static let sampleHabits = [
        Habit(
            title: "Sample habit 1",
            description: "Let's get to it!",
            colorString: "Orange"
        ),
        Habit(
            title: "Sample habit 2",
            description: "Get started now!",
            colorString: "Green"
        ),
        Habit(
            title: "Sample habit 3",
            description: "I can do this!",
            colorString: "Purple"
        )
    ]
}

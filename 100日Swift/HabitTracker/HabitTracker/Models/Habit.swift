//
//  Habit.swift
//  HabitTracker
//
//  Created by 澄界 on 2025/07/22.
//

import Foundation
import SwiftUI

//[Habit.()] 他のViewがここでの変数を参照される構造体
struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()//元々既存している情報を借りる
    let title: String
    let description: String
    let colorString: String? //切り替えが可能になる
    var completionCount: Int = 0
    
    //colorStringによる色
    var color: Color? {
        Color.habitColors.first { $0.value == colorString }?.key
    }
}

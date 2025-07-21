//
//  ExpenseItem.swift
//  iExpense
//
//  Created by 澄界 on 2025/07/21.
//

import Foundation

//変数の変化要因

//別のViewに依存される構造体、補足情報の上に変化を許可する
struct ExpenseItem: Codable, Identifiable {
    let name: String
    let type: ItemType
    let amount: Double
    //制度の既存する機能をテコにする変数
    var id = UUID()
    //識別要因
    enum ItemType: String, Codable, CaseIterable {
        case business = "ビジネス"
        case personal = "パーソナル"
    }
}

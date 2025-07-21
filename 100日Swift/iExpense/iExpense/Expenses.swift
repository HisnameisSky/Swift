//
//  Expenses.swift
//  iExpense
//
//  Created by 澄界 on 2025/07/21.
//

import Foundation

//支出項目ひとつずつの設定

//別の変数・外部による書類（この場合では別のView）が頼る構造体
class Expenses: ObservableObject {
private let itemKey = "項目"
    //依存される要素(別のViewへの指示とか)
    @Published var  selectedItemType: ExpenseItem.ItemType = .personal
    @Published private(set) var items: [ExpenseItem] = [] {
        didSet {
            guard let encoded = try? JSONEncoder().encode(items) else { return }
            //既存の機能をテコにする
            UserDefaults.standard.set(encoded, forKey: itemKey)
        }
    }
    //削除したいか保存したいかに応じるの設計
    init() {
        guard let savedItems = UserDefaults.standard.data(forKey: itemKey) else { return }
    
    guard let decoded = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) else { return }
        items = decoded
    }
    //追加する機能　.addItem() に設けられる
    func addItem(_ newItem: ExpenseItem) {
        items.append(newItem)
    }
    //削除する機能 .removeItems()に設けられる
    func removeItems(at offsets: IndexSet) {
        
        for offset in offsets {
            let itemToRemove = items.filter { $0.type == selectedItemType }[offset]
            let originalIndex = items.firstIndex { $0.id == itemToRemove.id }!
            //選択肢の削除指示
            items.remove(at: originalIndex)
        }
    }
    
}



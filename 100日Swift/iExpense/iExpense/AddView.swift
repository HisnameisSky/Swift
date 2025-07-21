//
//  AddView.swift
//  iExpense
//
//  Created by 澄界 on 2025/07/21.
//

import SwiftUI

//加えたい項目の画面表示

//構造体
struct AddView: View {
    
    //別のViewのclass構造を参照する変数
    @ObservedObject var expenses: Expenses
    //既存の機能をテコにする、この場合では解消の機能
    @Environment(\.dismiss) private var dismiss
    //依存される変数
    @State private var name = ""
    @State private var type: ExpenseItem.ItemType = .personal
    @State private var amount: Double = 0
    //紙幣通過の設定、自動検知式
    let currencyCode = Locale.current.currency?.identifier ?? "円"
    
    var body: some View {
        NavigationStack {
            //書類の表示
            Form {
                TextField("名前", text: $name)
                //選択肢に形式
                Picker("タイプ", selection: $type) {
                    ForEach(ExpenseItem.ItemType.allCases, id: \.self) { type in
                        Text(type.rawValue)
                    }
                }
                
                TextField(
                    "数量",
                    value: $amount,
                    format: .currency(code: currencyCode)
                )
                .keyboardType(.decimalPad)
            }
            //題名
            .navigationTitle("新しい支出")
            .navigationBarTitleDisplayMode(.inline)
            
            //右上にあるSaveボタン
            .toolbar {
                Button("保存") {
                    let item = ExpenseItem(
                        name: name,
                        type: type,
                        amount: amount
                    )
                    expenses.addItem(item)
                    dismiss()
                }
                //弄られないように設定する
                .disabled(
                    name.trimmingCharacters(in: .whitespaces).isEmpty
                )
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}

//
//  ExpenseLabel.swift
//  iExpense
//
//  Created by 澄界 on 2025/07/21.
//

import SwiftUI

//項目ひとつずつの表示設定

//構造体
struct ExpenseLabel: View {
    //変数概要
    let item: ExpenseItem
    
    private let currencyCode = Locale.current.currency?.identifier ?? "円"
    
    //変数による始動
    init(for item: ExpenseItem) {
        self.item = item
    }
    
    var body: some View {
        
        //表示される設計
        HStack {
            VStack(alignment: .leading) {
                
                //項目の名前
                Text(item.name)
                    .font(.headline)
                //⇧以上の種類
                Text(item.type.rawValue)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
            }
            Spacer()
            //項目の紙幣価値
            Text(
                item.amount, format: .currency(code: currencyCode)
            )
            .styledAmount(item.amount)
        }
        //既存機能をテコにする表示
        .accessibilityLabel("\(item.name), \(item.amount) \(currencyCode)")
    }
}

//表示と実例
#Preview(traits: .sizeThatFitsLayout) {
    ExpenseLabel(for: .init(name: "MacBook Pro", type: .business, amount: 2512.99))
        .padding()
}

//
//  ContentView.swift
//  iExpense
//
//  Created by 澄界 on 2025/07/21.
//

import SwiftUI

//表示する画面

//構造体
struct ContentView: View {
    
    //依存される変数
    @StateObject var expenses = Expenses()
    
    @State private var isShowingAddExpense = false
    
    //構造体の表示
    var body: some View {
        NavigationStack {
            List {
                Picker("支出のタイプ", selection: $expenses.selectedItemType) {
                    ForEach(
                        //ExpenseItemのViewにある構造体を参照する項目ひとつずつ施す設定
                        ExpenseItem.ItemType.allCases.reversed(),
                        id: \.self
                    ) { type in
                        Text(type.rawValue)
                    }
                }
                //特徴・お飾り
                .pickerStyle(.segmented)
                .listRowBackground(Color.clear)
                //追加されているひとつずつ項目の応用設定
                Section {
                    ForEach(
                        expenses.items.filter {
                            $0.type == expenses.selectedItemType
                        }
                    ) { item in
                        ExpenseLabel(for: item)
                    }
                    //削除したい場合の機能
                    .onDelete(perform: expenses.removeItems)
                }
            }
            //題名
            .navigationTitle("iExpense")
            //題名の下にある選択肢が可能の機能の設定
            .toolbar {
                Button("New expense", systemImage: "plus") {
                    isShowingAddExpense = true
                }
            }
            //追加ボタン（＋）を押した時に表示する項目の設定
            .sheet(isPresented: $isShowingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

//構造体
struct StyledAmount: ViewModifier {
    let amount: Double
    //表示
    func body(content: Content) -> some View {
        return content
            .foregroundStyle(getAmountColor(for: amount))
    }
    //記入した数量によって表示の色が変わる設定、１０、１００、１００以上に応じて色が変わる
    func getAmountColor(for amount: Double) -> Color {
        switch amount {
        case ..<10: return Color.green
        case 10..<100: return Color.blue
        case 100...: return Color.purple
        default: return Color.black
        }
    }
}
//色の変化が上手く作動するようにする拡張構造体
extension View {
    func styledAmount(_ amount: Double) -> some View {
        modifier(StyledAmount(amount: amount))
    }
}


#Preview {
    ContentView()
}

//
//  Order.swift
//  iDine
//
//  Created by 澄界 on 2025/08/04.
//

import SwiftUI

////[.]({:.})Class構造体・「注文」の画面
class Order: ObservableObject {
    //    別のViewによる変数
    @Published var items = [MenuItem]()
//    総合の方程式の変数
    var total: Int {
        if items.count > 0 {
            return items.reduce(0) { $0 + $1.price }
        } else {
            return 0
        }
    }
//    追加の機能
    func add(item: MenuItem) {
        items.append(item)
    }
//    削除の機能
    func remove(item: MenuItem) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
}

//
//  ItemDetail.swift
//  iDine
//
//  Created by 澄界 on 2025/08/04.
//

import SwiftUI

//[](:.)
struct ItemDetail: View {
//    OrderViewによる変数
    @EnvironmentObject var order: Order
    let item: MenuItem
    
    var body: some View {
//        表示の設定
        VStack {
            ZStack(alignment: .bottomTrailing) {
//                MenuのViewによる情報を借りる
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
//                MenuのViewによる情報を借りる２
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            }
            
            Text(item.description)
                .padding()
            
            Button("Order This") {
                order.add(item: item)
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ItemDetail(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}

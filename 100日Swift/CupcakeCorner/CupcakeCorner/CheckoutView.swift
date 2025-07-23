//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by 澄界 on 2025/07/23.
//

import SwiftUI

//決済の画面
struct CheckoutView: View {
    
    //Orderのclassの情報を参照
    @ObservedObject var orderObject: OrderObject
    //通知の伝言の設定
    @State private var confirmationMessage = ""
    @State private var isShowingConfirmationMessage = false
    @State private var isShowingFailureMessage = false
    //写真の原点
    private let imageUrl = URL(string: "https://hws.dev/img/cupcakes@3x.jpg")
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: imageUrl, scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)
                
                Text("お会計の代金は \(orderObject.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("ご注文の続き") {
                    Task {
                        await placeOrder()
                    }
                }
                .alert(
                    "誤作動が発生しました!",
                    isPresented: $isShowingFailureMessage
                ) {
                    Button("オッケー") { }
                } message: {
                    Text("ネット通信を確かめて後ほど改めてご確認くださいませ.")
                }
                .padding()
            }
        }
        .navigationTitle("決済")
        .navigationBarTitleDisplayMode(.inline)
        .alert("ありがとうございます!", isPresented: $isShowingConfirmationMessage) {
            Button("オッケー") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    //外部URLの情報を処理する機能
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(orderObject.order) else {
            return print("ご注文のEncondeが失敗しました.")
        }
        //より細かい情報の処理と確認
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.setValue("reqres-free-v1", forHTTPHeaderField: "x-api-key")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(
                for: request,
                from: encoded
            )
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "ご注文の \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) はまもなく届きます!"
            isShowingConfirmationMessage = true
        } catch {
            isShowingFailureMessage = true
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(
            orderObject: OrderObject()
        )
    }
}

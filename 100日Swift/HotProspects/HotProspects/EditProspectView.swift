//
//  EditProspectView.swift
//  HotProspects
//
//  Created by 澄界 on 2025/07/29.
//

import SwiftUI
import SwiftData

//「」。（）
struct EditProspectView: View {
    //全体に適用する設定
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    //定義
    var prospect: Prospect
    let states = ["contacted", "uncontacted"]
    //情報
    @State var name: String
    @State var emailAdress: String
    @State var isContacted: Bool
    
    var body: some View {
        
        Form {
            TextField("Name", text: $name)
            TextField("Email Address", text: $emailAdress)
            Picker("State", selection: $isContacted) {
                Text("contacted")
                    .tag(true)
                Text("uncontacted")
                    .tag(false)
            }
            //変更の設定
            .onChange(of: isContacted) {
                print("\(isContacted)")
            }
        }
        .navigationTitle("New Prospect")
        .toolbar {
            //ボタン
            Button("Save") {
                modelContext.delete(prospect)
                modelContext.insert(Prospect(name: name, emailAddress: emailAdress, isContacted: true))
                dismiss()
            }
        }
    }
}

//#Preview {
//    EditProspectView(prospect: Prospect, name: "unknown", emailAdress: "example", isContacted: true)
//}

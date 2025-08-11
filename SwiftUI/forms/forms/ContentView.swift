//
//  ContentView.swift
//  forms
//
//  Created by 澄界 on 2025/08/11.
//

import SwiftUI

//申請書類のお手本アプリ
//[]({:.})構造体
struct ContentView: View {
    
    //依存される変数
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = 20
    //パス関連
    private let oldPasswordToConfirmAgainst = "12345"
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmedPassword = ""
    //利用規約の関連
    @State private var location = ""
    @State private var termsAccepted = false
    //アニメーション専用
    @State private var keyboardOffset: CGFloat = 0
    
    //表示される要素
    var body: some View {
        
        VStack {
            NavigationView {
                //標識
                Form {
                    
                    Section(header: Text("User Details")) {
                        TextField("First name", text: $firstName)
                        TextField("Last name", text: $lastName)
                        
                        Picker(selection: $location, label: Text("Location")) {
                            ForEach(Location.allLocations, id: \.self) { location in
                                Text(location).tag(location)
                                
                            }
                        }
                        //切り替え式
                        Toggle(isOn: $termsAccepted, label: { Text("I accept the terms and conditions.")
                        })
                        //ステッパー式
                        Stepper(value: $age, in: 18...100, label: { Text("Current age: \(self.age)")
                        })
                        //条件に頼るボタン式の変数
                        if self.isUserInformationValid() {
                            Button(action: {
                                print("Updated profile")
                            }, label: {
                                Text("Updated Profile")
                            })
                        }
                        
                    }
                    //パス関連の概要欄
                    Section(header: Text("Password")) {
                        
                        SecureField("Enter old password", text: $oldPassword)
                        SecureField("New Password", text: $newPassword)
                        SecureField("Confirm New Password", text: $confirmedPassword)
                        //条件に頼る変数
                        if self.isPasswordValid() {
                            Button(action: {
                                print("Updated password")
                            }, label: {
                                Text("Update password")
                            })
                        }
                    }
                }
                //題名専用
                .navigationTitle(Text("Profile"))
            }
            //アニメーション専用のプロパティ
            .offset(y: -self.keyboardOffset)
            .onAppear {
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                                       object: nil,
                                                       queue: .main) { (notification) in
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardDidShowNotification,
                        object: nil,
                        queue: .main) { (notification) in
                            guard let userInfo = notification.userInfo,
                                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                            
                            self.keyboardOffset = keyboardRect.height
                        }
                    
                    NotificationCenter.default.addObserver(
                        forName: UIResponder.keyboardDidHideNotification,
                        object: nil,
                        queue: .main) { (notification) in
                            self.keyboardOffset = 0
                        }
                }
            }
        }
        .background(Color(UIColor.systemGray6))
    }
    //情報の認証機能
    private func isUserInformationValid() -> Bool {
        if firstName.isEmpty {
            return false
        }
        if lastName.isEmpty {
            return false
        }
        if !termsAccepted {
            return false
        }
        if location.isEmpty {
            return false
        }
        return true
    }
    //パスの認証機能
    private func isPasswordValid() -> Bool {
        if oldPassword != oldPasswordToConfirmAgainst {
            return false
        }
        if !newPassword.isEmpty && newPassword == confirmedPassword {
            return true
            
        }
        return false
    }
}

//[](.)構造体
struct Location {
    static let allLocations = [
        "New York",
        "London",
        "Tokyo",
        "Berlin",
        "Paris"
    ]
}

#Preview {
    ContentView()
}

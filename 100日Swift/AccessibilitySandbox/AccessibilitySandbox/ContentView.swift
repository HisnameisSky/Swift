//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by 澄界 on 2025/07/28.
//

import SwiftUI

struct ContentView: View {
//定義の概要欄
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks",
    ]
    //これで任意の画像に移れる
    @State private var selectedPicture = Int.random(in: 0...3)

    var body: some View {
//画像形式の表示
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()

            .onTapGesture {

                selectedPicture = Int.random(in: 0...3)
            }
        //より便利なアプリを作成するために追加すべきプロパティ
            .accessibilityLabel(labels[selectedPicture])
            .accessibilityAddTraits(.isButton)
            .accessibilityRemoveTraits(.isImage)
//ボタン形式の表示
        Button {
            selectedPicture = Int.random(in: 0...3)
        } label: {
            Image(pictures[selectedPicture])
                .resizable()
                .scaledToFit()
        }
        .accessibilityLabel(labels[selectedPicture])
    }
}

//struct ContentView: View {
//
//
//    var body: some View {
//
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .ignore)
//        .accessibilityLabel("Your score is 1000")
//
//    }
//}


//struct ContentView: View {
//
//    @State private var value = 12
//
//    var body: some View {
//        VStack {
//            Text("Value: \(value)")
//
//            Button("Increment") {
//                value += 1
//            }
//
//            Button("Decrement") {
//                value -= 1
//            }
//        }
//        .accessibilityElement()
//        .accessibilityLabel("Value")
//        .accessibilityValue(String(value))
//        .accessibilityAdjustableAction { direction in
//            switch direction {
//            case .increment:
//                value += 1
//            case .decrement:
//                value -= 1
//            default:
//                print("Not handled")
//            }
//        }
//    }
//}


//struct ContentView: View {
//
//    var body: some View {
//
//        Button("Tap!") {
//            print("Tapped")
//        }
//        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
//    }
//}


#Preview {
    ContentView()
}

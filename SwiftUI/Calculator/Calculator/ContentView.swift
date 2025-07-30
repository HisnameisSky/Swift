//
//  ContentView.swift
//  Calculator
//
//  Created by 澄界 on 2025/06/30.
//

import SwiftUI

//計算機の機能を借りて、それによる計算仕様を並べる
enum CalculatorOperation {
    case none, add, subtract, multiply, divide
}

struct ContentView: View {
    
    //アプリ要素の概要欄
    @State private var input = ""
    @State private var result = ""
    @State private var operation: CalculatorOperation = .none
    @State private var firstNumber = 0.0
    @State private var secondNumber = 0.0
    
    //アプリの表示されるボタン
    let buttons = [
        ["AC","+/-","%","/"],
        ["7","8","9","x"],
        ["4","5","6","-"],
        ["1","2","3","+"],
        ["0",".","=",]
    ]
    
    
    var body: some View {
        //重ねがけのスタック内側で計算機を作る
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            //縦式スタック内側で特徴を決める
            VStack {
                HStack {
                    Spacer()
                    Text(input.isEmpty ? result : input)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .padding()
                }
                //ボタンひとつずつにおける特徴を決める
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                self.buttonPressed(button)
                                self.provideHapticFeedback()
                            }, label: {
                                Text(button)
                                    .font(.title2)
                                    .foregroundColor(.black)
                                    .frame(width: self.buttonWidth(button), height: self.buttonHeight())
                                    .background(self.buttonColor(button))
                                    .cornerRadius(self.buttonWidth(button) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
            .padding()
        }
    }
    
    //ボタンひとつずつの機能・働きを決める
    func buttonPressed(_ button: String) {
        switch button {
        case "AC":
            clearAll()
        case "+/-":
            toggleSign()
        case "%":
            applyPercentage()
        case "/":
            setOperation(.divide)
        case "x":
            setOperation(.multiply)
        case "-":
            setOperation(.subtract)
        case "+":
            setOperation(.add)
        case "=":
            if let number = Double(input) {
                secondNumber = number
                calculateResult()
                input = result
            }
        case ".":
            if !input.contains(".") {
                input += "."
            }
        default:
            input += button
        }
    }
    
    //選んだ記号における仕様を決める
    func setOperation(_ operation: CalculatorOperation) {
        if let number = Double(input) {
            firstNumber = number
            self.operation = operation
            input = ""
            result = "\(number) \(operationSymbol(operation))"
        }
    }
    
    //計算の結果における仕様を決める
    func calculateResult() {
        var calculationResult: Double = 0.0
        
        switch operation {
        case .divide:
            if secondNumber != 0 {
                calculationResult = firstNumber / secondNumber
            } else {
                result = "Error"
                return
            }
        case .multiply:
            calculationResult = firstNumber * secondNumber
        case .subtract:
            calculationResult = firstNumber - secondNumber
        case .add:
            calculationResult = firstNumber + secondNumber
        case .none:
            return
        }
        
        result = String(format: "%.2f", calculationResult)
        clearAll(keepResult: true)
    }
    
    //記号の変更による機能
    func toggleSign() {
        if let number = Double(input) {
            input = String(-number)
        }
    }
    //割合を選んだ時の変更
    func applyPercentage() {
        if let number = Double(input) {
            input = String(number / 100)
        }
    }
    //消去記号を選んだ時の変更
    func clearAll(keepResult: Bool = false) {
        input = ""
        operation = .none
        firstNumber = 0.0
        secondNumber = 0.0
        if !keepResult {
            result = ""
        }
    }
    
    //選んだ記号の表示仕様
    func operationSymbol(_ operation: CalculatorOperation) -> String {
        switch operation {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "x"
        case .divide: return "/"
        case .none: return ""
        }
    }
    //記号の特徴
    func buttonWidth(_ button: String) -> CGFloat {
        return button == "0" ? (UIScreen.main.bounds.width - (5 * 12)) / 2 : (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    //記号の特徴
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    //記号の特徴・色
    func buttonColor(_ button: String) -> Color {
        switch button {
        case "AC", "+/-", "%":
            return Color.purple.opacity(0.8)
        case "/", "x", "-", "+", "=":
            return Color.blue.opacity(0.8)
        default:
            return Color.white.opacity(0.8)
        }
    }
    //押した時の可視化の効果を決める
    func provideHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

//表示されるようになるコード

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

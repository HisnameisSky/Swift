//
//  ContentView.swift
//  BetterRest
//
//  Created by 澄界 on 2025/07/18.
//

//CoreMLは別の書類から情報を借りる⇣
import CoreML
import SwiftUI

struct ContentView: View {
    
    
    //依存される定義やパラメータ
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    //通知専用
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    //カスタム可能なClosure
    private var sleepTime: Date? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            //睡眠時間の計算による予想
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            //睡眠時間の計算
            let sleepTime = wakeUp - prediction.actualSleep
            //通知の内容
            alertTitle = "Your ideal bedtime is.."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            return sleepTime
            
            //計算が失敗した場合の通知
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            return nil
        }
    }
    
    //一般的な変数の設定、日付
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 9
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        NavigationStack {
            //申請書類型
            Form {
                Section("Desired wakeup time") {
                    DatePicker(
                        "Please enter a time",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                }
                
                Section("Desired amount of sleep") {
                 Stepper(
                    "\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25
                 )
                }
                
                Section("Coffee consumption") {
                    Picker("Coffee consumption", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                }
                
                Section("Recommended bedtime") {
                    Text(sleepTime? .formatted(date: .omitted, time: .shortened) ?? "???")
                }
            }
            //申請書類型の下に追加
            .navigationTitle("BetterRest")
            .toolbar {
                Button("calculate", action: calculateBedTime)
            }
            
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    //計算の方程式の設定
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is.."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            //失敗した場合
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
    }
}


#Preview {
    ContentView()
}

//
//  ContentView.swift
//  UnitConversion
//
//  Created by 澄界 on 2025/07/15.
//

import SwiftUI

struct ContentView: View {
    
    //依存される要素
    @State private var inputNum: Double?
    @State private var inputUnits: UnitLength = .meters
    @State private var outputUnits: UnitLength = .feet
    @FocusState private var inputNumIsFocused: Bool
    //判定用
    var outputNum: Double? {
        guard let inputNum = inputNum else { return nil }
        let inputMeasurement = Measurement(value: inputNum, unit: inputUnits)
        return inputMeasurement.converted(to: outputUnits).value
    }
    
    //定義
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    var body: some View {
        NavigationStack {
            Form {
                //.meters
                Section("Input Units") {
                    Picker("Input units", selection: $inputUnits) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowBackground(Color.clear)
                
                //.kilometers
                Section("Outout Units") {
                    Picker("Output units", selection: $outputUnits) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .listRowBackground(Color.clear)
                //.feet
                Section("Input number") {
                    TextField("Enter a number", value: $inputNum, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputNumIsFocused)
                }
                //.yards
                Section("Result") {
                    Text(outputNum?.formatted() ?? "")
                }
            }
            .navigationTitle(Text("Unit Converter"))
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputNumIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

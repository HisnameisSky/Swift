//
//  CalculatorViewModel.swift
//  Ratios
//
//  Created by 澄界 on 2025/08/05.
//

import Foundation

//Gramsというの変数の機能と設定
typealias Grams = Double
class CalculatorViewModel {
    static func calculateGramsOfWaterTimes(waterRatio: Grams, coffee: Grams) -> Grams {
        return waterRatio * coffee
    }
}

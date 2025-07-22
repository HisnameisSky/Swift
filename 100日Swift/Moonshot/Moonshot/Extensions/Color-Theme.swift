//
//  Color-Theme.swift
//  Moonshot
//
//  Created by 澄界 on 2025/07/22.
//

import SwiftUI

//これらの植栽がShapeStyleが許可されている場所に使用可能
extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
}

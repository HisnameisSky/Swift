//
//  BudouView.swift
//  StackView
//
//  Created by 澄界 on 2025/05/18.
//

import SwiftUI

struct BudouView: View {
    var body: some View {
        HStack {
            Color.green.frame(width: 100, height: 20)
        }
        VStack {
            Color.green.frame(width: 20, height: 50)
        }
        HStack {
            Color.purple.frame(width: 60, height: 60)
            Color.purple.frame(width: 60, height: 60)
            Color.purple.frame(width: 60, height: 60)
            Color.purple.frame(width: 60, height: 60)
        }
        HStack {
            Color.purple.frame(width: 60, height: 60)
            Color.purple.frame(width: 60, height: 60)
            Color.purple.frame(width: 60, height: 60)
        }
        HStack {
            Color.purple.frame(width: 60, height: 60)
            Color.purple.frame(width: 60, height: 60)
        }
        HStack {
            Color.purple.frame(width: 60, height: 60)
        }
    }
}
//葡萄というのつもりでw
#Preview {
    BudouView()
}

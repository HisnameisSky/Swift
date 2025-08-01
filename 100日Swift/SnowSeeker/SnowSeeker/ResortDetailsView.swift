//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by 澄界 on 2025/08/01.
//

import SwiftUI

//[.](:.)
struct ResortDetailsView: View {
    
    let resort: Resort
    
    //多い選択肢のある変数
    var size: String {
        
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    //価格の表示は別Viewに応じて変わる
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                
                Text(size)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: Resort.example)
    }
}

//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by 澄界 on 2025/07/24.
//

import SwiftUI


//絵文字の評価[EmojiRatingView.]
struct EmojiRatingView: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("🫥")
        case 2:
            Text("😐")
        case 3:
            Text("😗")
        case 4:
            Text("🙂")
        default:
            Text("🙂‍↕️")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}

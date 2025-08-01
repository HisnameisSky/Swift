//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by 澄界 on 2025/08/01.
//

import SwiftUI

//[.](:.)歓迎画面
struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker!")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

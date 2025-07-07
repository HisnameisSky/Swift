//
//  DoraemonView.swift
//  StackView
//
//  Created by 澄界 on 2025/05/18.
//

import SwiftUI
//複雑なところがあるね
struct DoraemonView: View {
    var body: some View {
        ZStack {
            Color.blue.frame(width: 300, height: 300)
            VStack {
                //目の部分
                HStack {
                    //左目
                    ZStack {
                        //肉眼
                        Color.white.frame(width: 50, height: 80)
                        //瞳
                        Color.black.frame(width: 20, height: 20)
                    }
                    //口の部分
                    ZStack {
                        Color.white.frame(width: 50, height: 80)
                        Color.black.frame(width: 20, height: 20)
                    }
                }
                ZStack {
                    Color.white.frame(width: 250, height: 200)
                    HStack {
                        //左の髭
                        VStack {
                            Color.black.frame(width: 100, height: 10)
                            Color.black.frame(width: 100, height: 10)
                            Color.black.frame(width: 100, height: 10)
                        }
                        VStack {
                            //鼻
                            Color.red.frame(width: 30, height: 30)
                            //口
                            Color.red.frame(width: 100, height: 90)
                        }
                        //右の髭
                        VStack {
                            Color.black.frame(width: 100, height: 10)
                            Color.black.frame(width: 100, height: 10)
                            Color.black.frame(width: 100, height: 10)
                        }
                    }
                }
                
            }
        }
    }
}

#Preview {
    DoraemonView()
}

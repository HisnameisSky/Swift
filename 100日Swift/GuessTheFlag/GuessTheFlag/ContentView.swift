//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by 澄界 on 2025/07/16.
//

import SwiftUI

struct ContentView: View {
    
    //依存される定義専用
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland",
        "Italy", "Nigeria", "Poland", "Russia",
        "Spain", "UK", "US"
    ].shuffled()
    
    //現在の質問と回答
    @State private var currentQuestion = 1
    @State private var selectedAnswer = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    //採点の表示
    @State private var scoreTitle = ""
    @State private var isShowingScore = false
    @State private var isShowingGameOver = false
    //アニメーション専用
    @State private var isAnimatingOpacity = false
    @State private var rotationAmount = 0.0
    @State private var scaleAmount: CGFloat = 1.0
    //説明専用
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    //最大の質問の数量
    let questionAmount = 8
    
    //本題
    var body: some View {
        
        VStack {
            Spacer()
            
            Text("Guess the Flag")
                .font(.largeTitle.weight(.bold))
                .foregroundStyle(.white)
            
            Text("Current question: \(currentQuestion) / \(questionAmount)")
                .font(.title2)
                .foregroundColor(.white)
            
            //真ん中にある要素
            VStack(spacing: 15) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                //ボタンひとつずつの特徴
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        FlagImage(of: countries[number])
                            .accessibilityLabel(
                                labels[countries[number],
                                       default: "Unknown flag"]
                            )
                        
                            .opacity(isAnimatingOpacity ?
                                     (number == correctAnswer ? 1 : 0.25) : 1)
                        
                            .rotation3DEffect(
                                .degrees(number == selectedAnswer ? rotationAmount : 0),
                                axis: (x: 0, y: 1, z: 0))
                        
                            .scaleEffect(
                                number == correctAnswer ? 1 : scaleAmount,
                                anchor: .center)
                    }
                }
            }
            //真ん中の要素における追加特徴
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            //通知専用
            .alert(scoreTitle, isPresented: $isShowingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                scoreTitle == "Correct!" ? (
                    Text("Your score is now \(score)/\(questionAmount).")
                ) : (
                    Text("Sorry, that's the flag of \(countries[selectedAnswer])!")
                )
            }
            //真下に空間を空けるため
            Spacer()
            Spacer()
            //真下の本文の判定とそれにまつわる特徴
            Text("Score: \(score)/\(questionAmount)")
                .foregroundStyle(.white)
                .font(.title.bold())
                .fontWeight(.bold)
                .alert("Game over.", isPresented: $isShowingGameOver) {
                    Button("Play again", action: resetGame)
                } message: {
                    Text("Your final score is \(score)/\(questionAmount).")
                }
            Spacer()
            //本文の下に空間
        }
        .padding()
        
        //背景専用
        .background(
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            //これでカメラにあるところのノッチを無視する特徴
            .ignoresSafeArea()
        )
    }
    //側が押された機能を設定する
    func flagTapped(_ number: Int) {
        scoreTitle = number == correctAnswer ? "Correct!" : "Incorrect!"
        score = number == correctAnswer ? score + 1 : score
        
        selectedAnswer = number
        
        //アニメーション要素を加える
        withAnimation(.easeInOut) {
            isAnimatingOpacity = true
        }
        withAnimation {
            rotationAmount = 360
            scaleAmount = 0.5
        }
        //アニメーションの時に採点数を表示する
        isShowingScore = true
    }
    //質問を出す機能の設定
    func askQuestion() {
        if currentQuestion == questionAmount {
            isShowingGameOver = true
        } else {
            currentQuestion += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
        //以前の機能におけるアニメーションの設定
        isAnimatingOpacity = false
        rotationAmount = 0.0
        scaleAmount = 1.0
    }
    //ゲームを初期化する機能の設定
    func resetGame() {
        currentQuestion = 1
        score = 0
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

//旗の名前と画像を正しく設定する構造体
struct FlagImage: View {
    let country: String
    
    init(of country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}






#Preview {
    ContentView()
}

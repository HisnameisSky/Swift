//
//  CardView.swift
//  Flashzilla
//
//  Created by 澄界 on 2025/07/30.
//

import SwiftUI

//[.](:.)
struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    let card: Card
    @State private var isHidingAnswer = true
    @State private var offset = CGSize.zero
    var removal: ((Bool) -> Void)? = nil
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor
                    ? .white
                    : .white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : (offset.width < 0 ? .red : .white))
                )
                .shadow(radius: 10)
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isHidingAnswer ? card.prompt : card.answer)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    if !isHidingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width * 5)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if offset.width > 100 {
                        removal?(true)
                    } else if offset.width < -100 {
                        removal?(false)
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            isHidingAnswer.toggle()
        }
        .animation(.snappy, value: offset)
    }
}

#Preview {
    CardView(card: .example)
}

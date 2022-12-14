//
//  AffineAni.swift
//  SwiftUI_Practice
//
//  Created by Jong Won Moon on 2022/12/14.
//

import SwiftUI

enum Signal: Int {
    case go = 0, wait, stop

    var color: Color {
        switch self {
        case .go: return .green
        case .wait: return .yellow
        case .stop: return .red
        }
    }
}

struct AffineAni: View {

    @State var signal: Signal = .stop
    @State var isAnimating: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            Light(type: .go, isOn: signal == .go, scale: scale(.go))
            Light(type: .wait, isOn: signal == .wait, scale: scale(.wait))
            Light(type: .stop, isOn: signal == .stop, scale: scale(.stop))
        }
        .onTapGesture { tapped() }
    }

    func tapped() {
        isAnimating = true
        withAnimation(.linear(duration: 0.5)) {
            isAnimating = false
            let nextSignalRawValue = (signal.rawValue + 1) % 3
            signal = Signal(rawValue: nextSignalRawValue) ?? .stop
        }
    }
    
    func scale(_ of: Signal) -> Double {
        if isAnimating {
            return 0.0
        } else {
            return signal == of ? 1 : 0.8
        }
    }
}

struct Light: View {

    let type: Signal
    let isOn: Bool
    let scale: Double
    
    var body: some View {
        Circle()
            .foregroundColor(type.color.opacity(isOn ? 1: 0.5))
            .scaleEffect(scale)
    }
}

struct AffineAni_Previews: PreviewProvider {
    static var previews: some View {
        AffineAni()
    }
}


//
//  ContentView.swift
//  SignatureView
//
//  Created by Gustavo Cosme on 09/09/24.
//

import SwiftUI

struct SignatureExample {
    var text: String
    let font: UIFont
    let strokeColor: Color
    let fillColor: Color
    let background: LinearGradient
}

class SignatureExamples {

    static let examples: [SignatureExample] = [
        
        SignatureExample(
            text: "Hello",
            font: UIFont(name: "Bumbbled", size: 100)!,
            strokeColor: .gray.opacity(0.7),
            fillColor: .gray.opacity(0.5),
            background: LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
        ),
        
        SignatureExample(
            text: "SWIFTUI",
            font: .systemFont(ofSize: 66, weight: .heavy),
            strokeColor: .blue,
            fillColor: .white,
            background: LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .top, endPoint: .bottom)
        ),
        
        SignatureExample(
            text: "DESIGN",
            font: .monospacedDigitSystemFont(ofSize: 66, weight: .heavy),
            strokeColor: .black,
            fillColor: .black,
            background: LinearGradient(gradient: Gradient(colors: [.yellow, .yellow.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        ),
        SignatureExample(
            text: "APPLE",
            font: .systemFont(ofSize: 66, weight: .ultraLight),
            strokeColor: .white,
            fillColor: .white,
            background: LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        ),
        SignatureExample(
            text: "GOSTOU ?",
            font: .systemFont(ofSize: 66, weight: .ultraLight),
            strokeColor: .white.opacity(4.0),
            fillColor: .white,
            background: LinearGradient(gradient: Gradient(colors: [.indigo, .mint]), startPoint: .topLeading, endPoint: .bottomTrailing)
        ),
        SignatureExample(
            text: "{G}",
            font: UIFont(name: "DIN Condensed Bold", size: 150)!,
            strokeColor: .gray.opacity(0.5),
            fillColor: .white,
            background: LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
        ),
    ]
}

struct ContentView: View {
    
    @State private var currentIndex: Int = 0
    let examples = SignatureExamples.examples
    
    var body: some View {
        NavigationStack {
            if currentIndex < examples.count {
                let example = examples[currentIndex]
                
                NavigationLink(destination: ContentView(currentIndex: currentIndex + 1)) {
                    
                    AnimatedSignatureView(
                        text: example.text,
                        font: example.font,
                        strokeColor: example.strokeColor,
                        fillColor: example.fillColor
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(example.background)
                    .ignoresSafeArea()
                }
                .buttonStyle(NoTapAnimationStyle())

            } else {
               
            }
        }
        .navigationBarHidden(true)
    }
    
    init(currentIndex: Int) {
        self._currentIndex = State(initialValue: currentIndex)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentIndex: 0)
    }
}

struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}

//
//  AnimatedSignatureView.swift
//  SignatureView
//
//  Created by Gustavo Cosme on 09/09/24.
//

import SwiftUI

struct AnimatedSignatureView: View {
    @State private var drawingProgress: CGFloat = 0.0
    @State private var textAlpha: CGFloat = 0.0
    @State private var textAlpha2: CGFloat = 1.0
    
    let text: String
    let font: UIFont
    let strokeColor: Color
    let fillColor: Color
    let strokeAnimationDuration: Double
    let fadeOutAnimationDuration: Double
    let fadeOutDelay: Double
    let fadeInAnimationDuration: Double
    let fadeInDelay: Double
    
    init(text: String,
         font: UIFont = .systemFont(ofSize: 50),
         strokeColor: Color = .blue,
         fillColor: Color = .white,
         strokeAnimationDuration: Double = 5.0,
         fadeOutAnimationDuration: Double = 3.0,
         fadeOutDelay: Double = 2.0,
         fadeInAnimationDuration: Double = 3.0,
         fadeInDelay: Double = 2.0) {
        self.text = text
        self.font = font
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        self.strokeAnimationDuration = strokeAnimationDuration
        self.fadeOutAnimationDuration = fadeOutAnimationDuration
        self.fadeOutDelay = fadeOutDelay
        self.fadeInAnimationDuration = fadeInAnimationDuration
        self.fadeInDelay = fadeInDelay
    }

    var body: some View {
        ZStack {
            SignatureShape(text: text, font: font)
                .trim(from: 0, to: drawingProgress)
                .stroke(strokeColor, lineWidth: 2)
                .frame(width: getTextWidth(), height: getTextHeight())
                .opacity(textAlpha2)
                .onAppear { animateFadeOut() }
            
            SignatureShape(text: text, font: font)
                .fill(fillColor)
                .opacity(textAlpha)
                .frame(width: getTextWidth(), height: getTextHeight())
                .onAppear { animateFadeIn() }
        }
        .frame(height: getTextHeight())
        .onAppear { animateStroke() }
    }
    
    private func animateStroke() {
        withAnimation(.easeInOut(duration: strokeAnimationDuration)) {
            drawingProgress = 1.0
        }
    }
    
    private func animateFadeOut() {
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeOutDelay) {
            withAnimation(.easeInOut(duration: fadeOutAnimationDuration)) {
                textAlpha2 = 0.0
            }
        }
    }
    
    private func animateFadeIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeInDelay) {
            withAnimation(.easeInOut(duration: fadeInAnimationDuration)) {
                textAlpha = 1.0
            }
        }
    }
    
    private func getTextWidth() -> CGFloat {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width
    }
    
    private func getTextHeight() -> CGFloat {
        return font.lineHeight
    }
}

struct SignatureShape: Shape {
    let text: String
    let font: UIFont

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: font])
        let line = CTLineCreateWithAttributedString(attributedString)
        let runArray = CTLineGetGlyphRuns(line) as! [CTRun]
        
        let scaleY: CGFloat = -1
        let yOffset = (rect.height - font.lineHeight) / 2
        let transform = CGAffineTransform(scaleX: 1, y: scaleY).translatedBy(x: 0, y: rect.height / 2 + yOffset)
        
        for run in runArray {
            let glyphCount = CTRunGetGlyphCount(run)
            let attributes = CTRunGetAttributes(run) as NSDictionary
            let fontRef = attributes.value(forKey: kCTFontAttributeName as String) as! CTFont
            
            for glyphIndex in 0..<glyphCount {
                var glyph = CGGlyph()
                var glyphPosition = CGPoint()
                
                CTRunGetGlyphs(run, CFRangeMake(glyphIndex, 1), &glyph)
                CTRunGetPositions(run, CFRangeMake(glyphIndex, 1), &glyphPosition)
                
                if let letterPath = CTFontCreatePathForGlyph(fontRef, glyph, nil) {
                    let xOffset = glyphPosition.x
                    let letterTransform = CGAffineTransform(translationX: xOffset, y: glyphPosition.y)
                    path.addPath(Path(letterPath).applying(letterTransform).applying(transform))
                }
            }
        }
        return path
    }
}

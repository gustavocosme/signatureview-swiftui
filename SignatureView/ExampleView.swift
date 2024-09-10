//
//  ExampleView.swift
//  SignatureView
//
//  Created by Gustavo Cosme on 10/09/24.
//

import SwiftUI

struct ExampleView: View {
    
    var body: some View {
        
        VStack {
            
            AnimatedSignatureView(text: "Hello",
                                  font: UIFont(name: "Bumbbled",
                                               size: 88)!,
                                  strokeColor: .gray,
                                  fillColor: .gray)
            
        }
        
    }
}

#Preview {
    ExampleView()
}

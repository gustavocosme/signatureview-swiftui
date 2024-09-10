# Signatureview - Swiftui

AnimatedSignatureView

![alt text](https://github.com/gustavocosme/signatureview-swiftui/blob/main/gif.gif)

AnimatedSignatureView é uma View em SwiftUI que anima o desenho de um texto como uma assinatura com opções de customização para cor, fonte, e animações de preenchimento e desaparecimento.

# Propriedades

    text: String: O texto a ser exibido como assinatura.
    font: UIFont: A fonte utilizada para desenhar o texto. O valor padrão é .systemFont(ofSize: 50).
    strokeColor: Color: A cor da linha para a animação do traço. O valor padrão é Color.blue.
    fillColor: Color: A cor de preenchimento do texto após a animação do traço. O valor padrão é Color.white.
    strokeAnimationDuration: Double: Duração da animação de traço. O valor padrão é 5.0 segundos.
    fadeOutAnimationDuration: Double: Duração da animação de desaparecimento do traço. O valor padrão é 3.0 segundos.
    fadeOutDelay: Double: Atraso antes da animação de desaparecimento começar. O valor padrão é 2.0 segundos.
    fadeInAnimationDuration: Double: Duração da animação de aparecimento do preenchimento. O valor padrão é 3.0 segundos.
    fadeInDelay: Double: Atraso antes da animação de preenchimento começar. O valor padrão é 2.0 segundos.
    Métodos Privados
    animateStroke(): Anima o traço do texto da esquerda para a direita.
    animateFadeOut(): Anima o desaparecimento do traço após o atraso especificado.
    animateFadeIn(): Anima o preenchimento do texto após o atraso especificado.
    getTextWidth() -> CGFloat: Calcula e retorna a largura do texto.
    getTextHeight() -> CGFloat: Calcula e retorna a altura do texto.

# Exemplo de Uso

    import SwiftUI
    
    struct ContentView: View {
        var body: some View {
            VStack {
                AnimatedSignatureView(
                    text: "Gustavo Cosme",
                    font: .systemFont(ofSize: 60, weight: .bold),
                    strokeColor: .red,
                    fillColor: .yellow,
                    strokeAnimationDuration: 4.0,
                    fadeOutAnimationDuration: 2.5,
                    fadeOutDelay: 1.0,
                    fadeInAnimationDuration: 3.0,
                    fadeInDelay: 2.0
                )
                .frame(width: 300, height: 100)
            }
        }
    }

# Exemplo 2: Uso com configurações padrão

    import SwiftUI
    
    struct ContentView: View {
        var body: some View {
            AnimatedSignatureView(text: "Assinatura Padrão")
                .frame(width: 300, height: 100)
        }
    }





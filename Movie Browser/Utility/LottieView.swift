import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    var name: String
    var animationSpeed = 1.0
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: name)
        animationView.animationSpeed = animationSpeed
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let animationView = uiView.subviews.compactMap({ $0 as? LottieAnimationView }).first else { return }

        if isPlaying {
            if animationView.isAnimationPlaying { return }
            
            animationView.play { _ in
                isPlaying = false
            }
        } else {
            animationView.pause()
        }
    }
}

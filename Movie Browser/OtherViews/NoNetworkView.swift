import SwiftUI

struct NoNetworkView: View {
    private struct Constant {
        static let noNetworkImageName = "no_network"
        static let noNetworkText = "Network connection seems to be offline. Please check your connectivity."
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
                .frame(height: 200)
            
            Image(Constant.noNetworkImageName)
                .resizable()
                .frame(width: 41, height: 35)
            
            Text(Constant.noNetworkText)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .frame(width: 170)
            
            Spacer()
        }
    }
}

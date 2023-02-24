import SwiftUI

struct StarsView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { i in
                Image(viewModel.getStarImageName(at: i))
                    .resizable()
                    .frame(width: 15, height: 15)
            }
        }
    }
}

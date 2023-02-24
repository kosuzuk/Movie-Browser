import SwiftUI

struct SearchTopSectionView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    private struct Constant {
        static let searchPlaceholder = "Search for a movie..."
        static let starImageName = "star"
        static let favoritesButtonText = "Favorites"
        static let shimmerAnimDur = 3.0
        static let shimmerAnimRepeat = 30
    }
    
    var body: some View {
        HStack {
            TextField(Constant.searchPlaceholder, text: $viewModel.searchTextDisplayed)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .onSubmit {
                    viewModel.search()
                }
            
            
            NavigationLink(destination: FavoritesView(viewModel: FavoritesViewModel(apiCaller: Resolver().getAPICaller()))) {
                HStack(spacing: 5) {
                    Image(Constant.starImageName)
                        .resizable()
                        .frame(width: 15, height: 15)
                    
                    Text(Constant.favoritesButtonText)
                        .foregroundColor(.gray)
                }
                .padding(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.gray, lineWidth: 1)
                )
            }
            .shimmering(
                animation: .easeInOut(duration: Constant.shimmerAnimDur).repeatCount(Constant.shimmerAnimRepeat, autoreverses: false)
            )
        }
        .padding(15)
    }
}

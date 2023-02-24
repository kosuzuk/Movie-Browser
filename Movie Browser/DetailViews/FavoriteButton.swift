import SwiftUI

struct FavoriteButton: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    private struct Constant {
        static let starImageName = "star"
        static let delete = "Delete"
        static let emptyStarImageName = "empty_star"
        static let favorite = "Favorite"
        static let starsLottieAnimName = "stars"
    }
    
    var body: some View {
        Button {
            viewModel.favoriteButtonOnPressed()
        } label: {
            ZStack(alignment: .leading) {
                HStack(spacing: 5) {
                    if viewModel.isFavorited {
                        Image(Constant.starImageName)
                            .resizable()
                            .frame(width: 17, height: 17)
                        
                        Text(Constant.delete)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    } else {
                        Image(Constant.emptyStarImageName)
                            .resizable()
                            .frame(width: 17, height: 17)
                        
                        Text(Constant.favorite)
                            .foregroundColor(.gray)
                        
                        Spacer()
                    }
                }
                .frame(width: 100)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 0))
                .background(Color.white)
                .cornerRadius(7)
                .overlay(
                    RoundedRectangle(cornerRadius: 7)
                        .stroke(.gray, lineWidth: 1)
                )
                
                LottieView(isPlaying: $viewModel.playingStarsAnimation, name: Constant.starsLottieAnimName, animationSpeed: 1.2)
                    .frame(width: 40, height: 40)
            }
            
        }
    }
}

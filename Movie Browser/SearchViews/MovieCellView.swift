import SwiftUI
import Kingfisher

struct MovieCellView: View {
    let movie: Movie
    let isFavorited: Bool
    
    private struct Constant {
        static let imageBaseUrl = "https://image.tmdb.org/t/p/original"
        static let width = (UIScreen.main.bounds.width - 30) / 2
        static let height = (UIScreen.main.bounds.width) / 1.7
        static let noImage = "No image"
        static let starImageName = "star"
        static let fadeInDur = 0.4
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let posterPath = movie.poster_path {
                KFImage(URL(string: Constant.imageBaseUrl + posterPath)!)
                    .fade(duration: Constant.fadeInDur)
                    .resizable()
                    .frame(width: Constant.width, height: Constant.height)
            } else {
                Text(Constant.noImage)
                    .foregroundColor(.gray)
                    .frame(width: Constant.width, height: Constant.height)
            }
            
            if isFavorited {
                Image(Constant.starImageName)
                    .resizable()
                    .frame(width: 17, height: 17)
                    .padding(10)
            }
        }
    }
}

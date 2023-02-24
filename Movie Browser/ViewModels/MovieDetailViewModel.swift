import SwiftUI

class MovieDetailViewModel: ObservableObject {
    @Published var detail: MovieDetail?
    @Published var isFavorited: Bool
    @Published var playingStarsAnimation = false
    let id: Int
    var unfavoriteMovie: ((Int) -> ())?
    let apiCaller: APICallerProtocol
    let realmManager = RealmManager()
    
    private struct Constant {
        static let starImageName = "star"
        static let halfStarImageName = "half_star"
        static let emptyStarImageName = "empty_star"
    }
    
    init(apiCaller: APICallerProtocol, isFavorited: Bool, id: Int, unfavoriteMovie: ((Int) -> ())? = nil) {
        self.apiCaller = apiCaller
        self.isFavorited = isFavorited
        self.id = id
        self.unfavoriteMovie = unfavoriteMovie
    }
    
    func getStarImageName(at index: Int) -> String {
        // Will be called 5 times, once for each star image to display the rating
        guard let rating = detail?.vote_average else { return "" }
        
        let index = Double(index)
        if rating / 2 - index > 0.8 {
            return Constant.starImageName
        } else if rating / 2 - index > 0.2 {
            return Constant.halfStarImageName
        } else {
            return Constant.emptyStarImageName
        }
    }
    
    func favoriteButtonOnPressed() {
        if isFavorited {
            realmManager.deleteFavoritedMovieId(id: id)
            isFavorited = false
        } else {
            realmManager.saveFavoritedMovieId(id: id)
            isFavorited = true
            playingStarsAnimation = true
        }
    }
}

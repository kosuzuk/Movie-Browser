import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var onAppearCalled = false
    let apiCaller: APICallerProtocol
    let realmManager = RealmManager()
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]
    
    init(apiCaller: APICallerProtocol) {
        self.apiCaller = apiCaller
    }
    
    func getFavoritedMovies() {
        let moviesIds = realmManager.getFavoritedMovieIds()
        for id in moviesIds {
            apiCaller.getMovieById(id: id) { [weak self] movie in
                DispatchQueue.main.async {
                    self?.movies.append(movie)
                }
            }
        }
    }
    
    func getMovieDetailView(isFavorited: Bool, movieId: Int) -> MovieDetailView {
        let vm = MovieDetailViewModel(apiCaller: Resolver().getAPICaller(), isFavorited: isFavorited, id: movieId, unfavoriteMovie: { [weak self] id in self?.unfavoriteMovie(id: id) })
        return MovieDetailView(viewModel: vm)
    }
    
    func unfavoriteMovie(id: Int) {
        movies.remove(at: movies.firstIndex(where: { $0.id == id })!)
    }
}

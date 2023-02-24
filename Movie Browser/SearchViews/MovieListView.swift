import SwiftUI
import Swinject

struct MovieListView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    private struct Constant {
        static let noResults = "No results"
    }
    
    private func getMovieDetailView(isFavorited: Bool, movieId: Int) -> MovieDetailView {
        let vm = MovieDetailViewModel(apiCaller: Resolver().getAPICaller(), isFavorited: isFavorited, id: movieId)
        return MovieDetailView(viewModel: vm)
    }
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                VStack {
                    if !viewModel.displayedMovies.isEmpty {
                        LazyVGrid(columns: viewModel.columns, spacing: 5) {
                            ForEach(viewModel.displayedMovies, id: \.id) { movie in
                                let movieDetailView = getMovieDetailView(isFavorited: viewModel.isFavorited(id: movie.id), movieId: movie.id)
                                let movieCellView = MovieCellView(movie: movie, isFavorited: viewModel.isFavorited(id: movie.id))
                                NavigationLink(destination: movieDetailView){
                                    movieCellView
                                }
                            }
                        }
                        .padding(7)
                        
                        if viewModel.totalPages > 1 {
                            MovieListPageNumberView(viewModel: viewModel, scrollToTopFunc: { reader.scrollTo(viewModel.topViewId, anchor: .top) })
                        }
                    } else {
                        Text(Constant.noResults)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                        .frame(height: 80)
                }
                .id(viewModel.topViewId)
            }
        }
    }
}

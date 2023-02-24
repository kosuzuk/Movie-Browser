import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var viewModel: FavoritesViewModel
    
    private struct Constant {
        static let noFavorites = "No favorited movies"
        static let favoriteMovies = "⭐Favorite Movies"
    }
    
    var body: some View {
        VStack {
            if networkMonitor.isConnected {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        if !viewModel.movies.isEmpty {
                            Spacer()
                                .frame(height: 20)
                            
                            LazyVGrid(columns: viewModel.columns, spacing: 5) {
                                ForEach(viewModel.movies, id: \.id) { movie in
                                    let detailView = viewModel.getMovieDetailView(isFavorited: true, movieId: movie.id)
                                    NavigationLink(destination: detailView) {
                                        MovieCellView(movie: movie, isFavorited: true)
                                    }
                                }
                            }
                            .padding(7)
                            .ignoresSafeArea()
                            
                            Spacer()
                                .frame(height: 70)
                        } else {
                            VStack {
                                Spacer()
                                    .frame(height: 40)
                                
                                Text(Constant.noFavorites)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                        .frame(height: 80)
                }
                .edgesIgnoringSafeArea(.bottom)
            } else {
                NoNetworkView()
            }
        }
        .navigationTitle(Constant.favoriteMovies)
        .onAppear {
            if !viewModel.onAppearCalled {
                viewModel.getFavoritedMovies()
                viewModel.onAppearCalled = true
            }
        }
    }
}

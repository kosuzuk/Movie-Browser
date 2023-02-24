import SwiftUI
import Shimmer

struct SearchView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if networkMonitor.isConnected {
                    SearchTopSectionView(viewModel: viewModel)
                    
                    ZStack(alignment: .bottom) {
                        MovieListView(viewModel: viewModel)
                     
                        LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 80)
                    }
                    .ignoresSafeArea()
                } else {
                    NoNetworkView()
                }
            }
            .onAppear {
                // Called when navigating back from child view
                viewModel.favoritedMovieIds = viewModel.realmManager.getFavoritedMovieIds()
            }
        }
        .onAppear {
            // Not called when navigating back from child view
            viewModel.apiCaller.getMovies(keyword: viewModel.initialSearch, pageNumber: 1) { response in
                DispatchQueue.main.async {
                    viewModel.displayedMovies = response.results
                }
            }
        }
    }
}

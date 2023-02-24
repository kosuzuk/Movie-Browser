import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @ObservedObject var viewModel: MovieDetailViewModel
    
    private struct Constant {
        static let movieDetails = "Movie Details"
    }
    
    var body: some View {
        VStack {
            if networkMonitor.isConnected {
                ScrollView {
                    MovieDetailViewContent(viewModel: viewModel)
                }
            } else {
                NoNetworkView()
            }
        }
        .navigationTitle(Constant.movieDetails)
        .onAppear {
            viewModel.apiCaller.getMovieDetail(movieId: viewModel.id) { detail in
                DispatchQueue.main.async {
                    viewModel.detail = detail
                }
            }
        }
        .onDisappear {
            // If the movie is not favorited and is navigating back to favorites view, remove the movie from the favorites list
            if !viewModel.isFavorited {
                viewModel.unfavoriteMovie?(viewModel.id)
            }
        }
    }
}

struct MovieDetailViewContent: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    private struct Constant {
        static let imageBaseUrl = "https://image.tmdb.org/t/p/original"
        static let backdropImageWidth = UIScreen.main.bounds.width
        static let backdropImageHeight = UIScreen.main.bounds.width * 0.6
        static let posterImageWidth = UIScreen.main.bounds.width * 0.2
        static let posterImageHeight = UIScreen.main.bounds.width * 0.32
        static let langs = "Spoken languages:"
        static let length = "Length: "
        static let minutes = " minutes"
        static let released = "Released: "
        static let moreInfo = "More info"
        static let adult = "Adult"
        static let fadeInDur = 0.4
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let detail = viewModel.detail {
                if let imagePath = detail.backdrop_path {
                    ZStack(alignment: .topTrailing) {
                        //banner image
                        KFImage(URL(string: Constant.imageBaseUrl + imagePath)!)
                            .fade(duration: Constant.fadeInDur)
                            .resizable()
                            .frame(width: Constant.backdropImageWidth, height: Constant.backdropImageHeight)
                        
                        FavoriteButton(viewModel: viewModel)
                            .padding(10)
                    }
                } else {
                    HStack {
                        Spacer()
                        
                        FavoriteButton(viewModel: viewModel)
                            .padding(10)
                    }
                }
                
                HStack(alignment: .top) {
                    if let imagePath = detail.poster_path {
                        // movie image
                        KFImage(URL(string: Constant.imageBaseUrl + imagePath)!)
                            .fade(duration: Constant.fadeInDur)
                            .resizable()
                            .frame(width: Constant.posterImageWidth, height: Constant.posterImageHeight)
                            .padding(EdgeInsets(top: 3, leading: 10, bottom: 0, trailing: 0))
                    } else {
                        Spacer()
                            .frame(width: 17)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(detail.title)
                            .fontWeight(.bold)
                        
                        HStack {
                            StarsView(viewModel: viewModel)
                            
                            Text("(\(detail.vote_count))")
                        }
                        
                        Spacer()
                            .frame(height: 7)
                        
                        Text(detail.overview ?? "")
                            .font(.system(size: 11))
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(Constant.langs)
                        
                        ForEach(detail.spoken_languages.map{ $0.name }, id: \.self) { lang in
                            Text(lang)
                        }
                    }
                    
                    if let time = detail.runtime {
                        Text(Constant.length + String(time) + Constant.minutes)
                    }
                    
                    Text(Constant.released + detail.release_date)
                    
                    if let page = detail.homepage, !page.isEmpty {
                        Link(Constant.moreInfo, destination: URL(string: page)!)
                            .foregroundColor(.blue)
                    }
                    
                    if detail.adult {
                        Text(Constant.adult)
                            .foregroundColor(.red)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(.red, lineWidth: 1)
                            )
                    }
                }
                .foregroundColor(.gray)
                .padding(15)
            }
            
            Spacer()
        }
    }
}

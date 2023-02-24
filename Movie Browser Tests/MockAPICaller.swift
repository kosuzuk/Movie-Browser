@testable import Movie_Browser

class MockAPICaller: APICallerProtocol {
    private let movie = Movie(poster_path: "poster_path", adult: false, overview: "overview", release_date: "2020-9-14", genre_ids: [0], id: 0, original_title: "original_title", original_language: "original_language", title: "title", backdrop_path: "backdrop_path", popularity: 4.4, vote_count: 1, video: false, vote_average: 7.8)
    private let movieDetail = MovieDetail(adult: false, budget: 10, genres: [Genre(id: 2, name: "comedy")], id: 0, original_language: "original_language", original_title: "original_title", popularity: 4.4, production_companies: [Company(name: "name", id: 1, origin_country: "us")], production_countries: [Country(iso_3166_1: "", name: "us")], release_date: "2020-9-14", revenue: 10, spoken_languages: [Language(iso_639_1: "", name: "en")], status: "status", title: "title", video: false, vote_average: 9.8, vote_count: 2)
    
    func getMovies(keyword: String, pageNumber: Int, completionHandler: @escaping (Movie_Browser.FetchMoviesResponse) -> Void) {
        let response = FetchMoviesResponse(results: [movie], page: 1, total_pages: 1, total_results: 1)
        completionHandler(response)
    }
    
    func getMovieDetail(movieId: Int, completionHandler: @escaping (Movie_Browser.MovieDetail) -> Void) {
        completionHandler(movieDetail)
    }
    
    func callApi(gettingMovieList: Bool, keyword: String, pageNumber: Int, movieId: Int, fetchMoviesCompletion: ((Movie_Browser.FetchMoviesResponse) -> Void)?, fetchMovieDetailCompletion: ((Movie_Browser.MovieDetail) -> Void)?) {
        if let completion = fetchMoviesCompletion {
            let response = FetchMoviesResponse(results: [movie], page: 1, total_pages: 1, total_results: 1)
            completion(response)
            return
        }
        
        if let completion = fetchMovieDetailCompletion {
            completion(movieDetail)
            return
        }
    }
    
    func getMovieById(id: Int, completionHandler: @escaping (Movie_Browser.Movie) -> Void) {
        completionHandler(movie)
    }
    
    func getMoviesById(movieIds: [Int], completionHandler: @escaping ([Movie_Browser.Movie]) -> Void) {
        completionHandler([movie])
    }
}

protocol APICallerProtocol {
    func getMovies(keyword: String, pageNumber: Int, completionHandler: @escaping (FetchMoviesResponse) -> Void)
    
    func getMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetail) -> Void)
    
    func callApi(gettingMovieList: Bool, keyword: String, pageNumber: Int, movieId: Int, fetchMoviesCompletion: ((FetchMoviesResponse) -> Void)?, fetchMovieDetailCompletion: ((MovieDetail) -> Void)?)
    
    func getMovieById(id: Int, completionHandler: @escaping (Movie) -> Void)
    
    func getMoviesById(movieIds: [Int], completionHandler: @escaping ([Movie]) -> Void)
}

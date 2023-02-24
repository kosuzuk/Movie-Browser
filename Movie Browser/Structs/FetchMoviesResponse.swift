struct FetchMoviesResponse: Decodable {
    var results: [Movie]
    var page: Int
    var total_pages: Int
    var total_results: Int
}

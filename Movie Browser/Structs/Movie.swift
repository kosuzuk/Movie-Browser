struct Movie: Decodable {
    var poster_path: String?
    var adult: Bool
    var overview: String
    var release_date: String
    var genre_ids: [Int]
    var id: Int
    var original_title: String
    var original_language: String
    var title: String
    var backdrop_path: String?
    var popularity: Double
    var vote_count: Int
    var video: Bool
    var vote_average: Double
    
    init(poster_path: String?, adult: Bool, overview: String, release_date: String, genre_ids: [Int], id: Int, original_title: String, original_language: String, title: String, backdrop_path: String?, popularity: Double, vote_count: Int, video: Bool, vote_average: Double) {
        self.poster_path = poster_path
        self.adult = adult
        self.overview = overview
        self.release_date = release_date
        self.genre_ids = genre_ids
        self.id = id
        self.original_title = original_title
        self.original_language = original_language
        self.title = title
        self.backdrop_path = backdrop_path
        self.popularity = popularity
        self.vote_count = vote_count
        self.video = video
        self.vote_average = vote_average
    }
    
    init(detail: MovieDetail) {
        poster_path = detail.poster_path
        adult = detail.adult
        overview = detail.overview ?? ""
        release_date = detail.release_date
        
        var genreIds: [Int] = []
        for genre in detail.genres {
            genreIds.append(genre.id)
        }
        genre_ids = genreIds
        
        id = detail.id
        original_title = detail.original_title
        original_language = detail.original_language
        title = detail.title
        backdrop_path = detail.backdrop_path
        popularity = detail.popularity
        vote_count = detail.vote_count
        video = detail.video
        vote_average = detail.vote_average
    }
}

struct MovieDetail: Decodable {
    var adult: Bool
    var backdrop_path: String?
    var belongs_to_collection: Collection?
    var budget: Int
    var genres: [Genre]
    var homepage: String?
    var id: Int
    var imdb_id: String?
    var original_language: String
    var original_title: String
    var overview: String?
    var popularity: Double
    var poster_path: String?
    var production_companies: [Company]
    var production_countries: [Country]
    var release_date: String
    var revenue: Int
    var runtime: Int?
    var spoken_languages: [Language]
    var status: String
    var tagline: String?
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}

struct Collection: Decodable {
    var id: Int
    var name: String
    var poster_path: String?
    var backdrop_path: String?
}

struct Genre: Decodable {
    var id: Int
    var name: String
}

struct Company: Decodable {
    var name: String
    var id: Int
    var logo_path: String?
    var origin_country: String
}

struct Country: Decodable {
    var iso_3166_1: String
    var name: String
}

struct Language: Decodable {
    var iso_639_1: String
    var name: String
}

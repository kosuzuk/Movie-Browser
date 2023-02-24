import Foundation

class APICaller: APICallerProtocol {
    private let getMoviesUrl = "https://api.themoviedb.org/3/search/movie?"
    private let getMovieDetailUrl = "https://api.themoviedb.org/3/movie/"
    private let apiKey = "4476183a969799cb27b419985af6336f"
    
    func getMovies(keyword: String, pageNumber: Int = 1, completionHandler: @escaping (FetchMoviesResponse) -> Void) {
        callApi(gettingMovieList: true, keyword: keyword, pageNumber: pageNumber, fetchMoviesCompletion: completionHandler)
    }
    
    func getMovieDetail(movieId: Int, completionHandler: @escaping (MovieDetail) -> Void) {
        callApi(gettingMovieList: false, movieId: movieId, fetchMovieDetailCompletion: completionHandler)
    }
    
    internal func callApi(gettingMovieList: Bool, keyword: String = "", pageNumber: Int = 1, movieId: Int = 0, fetchMoviesCompletion: ((FetchMoviesResponse) -> Void)? = nil, fetchMovieDetailCompletion: ((MovieDetail) -> Void)? = nil) {
        let url: URL
        if gettingMovieList {
            // Get a list of movies by keyword
            let keyword = keyword.replacingOccurrences(of: " ", with: "-", options: .literal, range: nil)
            url = URL(string: getMoviesUrl + "api_key=\(apiKey)&" + "query=\(keyword)" + "&page=\(pageNumber)")!
        } else {
            // Get details for a movie with ID
            url = URL(string: getMovieDetailUrl + "\(movieId)" + "?api_key=\(apiKey)")!
        }

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            // Check status code
            guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
                print("Error with response, unexpected status code: \(String(describing: response))")
                return
            }
            
            guard let data = data else {
                print("response data is nil")
                return
            }
            
            do {
                // Decode the response, based on which API is used
                if gettingMovieList {
                    let response = try JSONDecoder().decode(FetchMoviesResponse.self, from: data)
                    fetchMoviesCompletion?(response)
                } else {
                    let response = try JSONDecoder().decode(MovieDetail.self, from: data)
                    fetchMovieDetailCompletion?(response)
                }
            } catch {
                print("Error while decoding: \(error)")
            }
        })
        
        task.resume()
    }
    
    func getMovieById(id: Int, completionHandler: @escaping (Movie) -> Void) {
        getMovieDetail(movieId: id) { detail in
            completionHandler(Movie(detail: detail))
        }
    }
    
    // Unused
    func getMoviesById(movieIds: [Int], completionHandler: @escaping ([Movie]) -> Void) {
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)
        
        var res: [Movie] = []
        for id in movieIds {
            dispatchQueue.async(group: dispatchGroup) { [weak self] in
                self?.getMovieDetail(movieId: id) { detail in
                    res.append(Movie(detail: detail))
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            // Call the completion handler after all tasks are complete
            completionHandler(res)
        }
    }
}

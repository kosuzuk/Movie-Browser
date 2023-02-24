import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var searchTextDisplayed = ""
    @Published var searchTextUsed = ""
    @Published var displayedMovies: [Movie] = []
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var favoritedMovieIds: [Int] = []
    let apiCaller: APICallerProtocol
    let realmManager = RealmManager()
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0),
    ]
    let initialSearch = "disney"
    let topViewId = "0"
    var isFirstPage: Bool {
        currentPage == 1
    }
    var isLastPage: Bool {
        currentPage == totalPages
    }
    
    init(apiCaller: APICallerProtocol) {
        self.apiCaller = apiCaller
    }
    
    func search() {
        apiCaller.getMovies(keyword: searchTextDisplayed, pageNumber: 1) { response in
            DispatchQueue.main.async { [weak self] in
                self?.searchTextUsed = self?.searchTextDisplayed ?? ""
                self?.displayedMovies = response.results
                self?.currentPage = 1
                self?.totalPages = response.total_pages
            }
        }
    }
    
    func isFavorited(id: Int) -> Bool {
        favoritedMovieIds.contains(id)
    }
    
    func changePage(newPage: Int) {
        apiCaller.getMovies(keyword: searchTextUsed, pageNumber: newPage) { response in
            DispatchQueue.main.async {
                self.displayedMovies = response.results
                self.currentPage = newPage
            }
        }
    }
}

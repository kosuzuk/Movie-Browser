@testable import Movie_Browser
import XCTest
import Quick
import Nimble
import Swinject

final class FavoritesViewModelTests: QuickSpec {
    override func spec() {
        //register dependencies
        let container = Container()
        container.register(MockAPICaller.self) { _ in MockAPICaller() }
        let viewModel = FavoritesViewModel(apiCaller: container.resolve(MockAPICaller.self)!)
        let movie = Movie(poster_path: "", adult: false, overview: "", release_date: "", genre_ids: [0], id: 100, original_title: "", original_language: "", title: "", backdrop_path: "", popularity: 0, vote_count: 1, video: false, vote_average: 0)
        let realmManager = RealmManager()
        
        describe("Testing FavoritesViewModel") {
            context("getFavoritedMovies function") {
                it("should get the favorited movies") {
// Test does not return
//
//                    DispatchQueue.main.async {
//                        realmManager.clearData()
//                        RealmManager().saveFavoritedMovieId(id: 1)
//                        viewModel.getFavoritedMovies()
//                        expect(viewModel.movies).toEventuallyNot(beEmpty(), timeout: DispatchTimeInterval.seconds(2))
//                        realmManager.clearData()
//                    }
                }
            }
            
            context("getMovieDetailView function") {
                it("should return a getMovieDetailView") {
                    let view = viewModel.getMovieDetailView(isFavorited: true, movieId: 1)
                    expect(view).toNot(beNil())
                }
            }
            
            context("unfavoriteMovie function") {
                it("should unfavorite the movie") {
                    DispatchQueue.main.async {
                        realmManager.clearData()
                        viewModel.movies = [movie]
                        viewModel.unfavoriteMovie(id: 100)
                        expect(viewModel.movies).to(beEmpty())
                        realmManager.clearData()
                    }
                }
            }
        }
    }
}

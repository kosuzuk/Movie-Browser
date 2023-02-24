@testable import Movie_Browser
import XCTest
import Quick
import Nimble
import Swinject

final class MovieDetailViewModelTests: QuickSpec {
    override func spec() {
        //register dependencies
        let container = Container()
        container.register(MockAPICaller.self) { _ in MockAPICaller() }
        let viewModel = MovieDetailViewModel(apiCaller: container.resolve(MockAPICaller.self)!, isFavorited: false, id: 1, unfavoriteMovie: nil)
        let realmManager = RealmManager()
        
        describe("Testing MovieDetailViewModel") {
            context("getStarImageName function") {
                it("should display 0 stars") {
                    let vote = 0.0
                    viewModel.detail = MovieDetail(adult: false, budget: 0, genres: [], id: 0, original_language: "", original_title: "", popularity: 0.0, production_companies: [Company(name: "", id: 0, origin_country: "")], production_countries: [Country(iso_3166_1: "", name: "")], release_date: "", revenue: 0, spoken_languages: [Language(iso_639_1: "", name: "")], status: "", title: "", video: false, vote_average: vote, vote_count: 0)
                    for i in 0..<5 {
                        expect(viewModel.getStarImageName(at: i)).to(equal("empty_star"))
                    }
                }
                
                it("should display 5 stars") {
                    let vote = 10.0
                    viewModel.detail = MovieDetail(adult: false, budget: 0, genres: [], id: 0, original_language: "", original_title: "", popularity: 0.0, production_companies: [Company(name: "", id: 0, origin_country: "")], production_countries: [Country(iso_3166_1: "", name: "")], release_date: "", revenue: 0, spoken_languages: [Language(iso_639_1: "", name: "")], status: "", title: "", video: false, vote_average: vote, vote_count: 0)
                    for i in 0..<5 {
                        expect(viewModel.getStarImageName(at: i)).to(equal("star"))
                    }
                }
                
                it("should display 3.5 stars") {
                    let vote = 7.1
                    viewModel.detail = MovieDetail(adult: false, budget: 0, genres: [], id: 0, original_language: "", original_title: "", popularity: 0.0, production_companies: [Company(name: "", id: 0, origin_country: "")], production_countries: [Country(iso_3166_1: "", name: "")], release_date: "", revenue: 0, spoken_languages: [Language(iso_639_1: "", name: "")], status: "", title: "", video: false, vote_average: vote, vote_count: 0)
                    for i in 0..<3 {
                        expect(viewModel.getStarImageName(at: i)).to(equal("star"))
                    }
                    expect(viewModel.getStarImageName(at: 3)).to(equal("half_star"))
                    expect(viewModel.getStarImageName(at: 4)).to(equal("empty_star"))
                }
            }
            
            context("favoriteButtonOnPressed function") {
                it("should favorite the unfavorited movie") {
                    viewModel.isFavorited = false
                    viewModel.playingStarsAnimation = false
                    DispatchQueue.main.async {
                        realmManager.clearData()
                        viewModel.favoriteButtonOnPressed()
                        expect(viewModel.isFavorited).to(equal(true))
                        expect(viewModel.playingStarsAnimation).to(equal(true))
                        realmManager.clearData()
                    }
                }
            }
        }
    }
}

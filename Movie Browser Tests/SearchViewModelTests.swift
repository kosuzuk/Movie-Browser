@testable import Movie_Browser
import XCTest
import Quick
import Nimble
import Swinject

final class SearchViewModelTests: QuickSpec {
    override func spec() {
        //register dependencies
        let container = Container()
        container.register(MockAPICaller.self) { _ in MockAPICaller() }
        let viewModel = SearchViewModel(apiCaller: container.resolve(MockAPICaller.self)!)
        
        describe("Testing SearchViewModel") {
            context("isFirstPage property") {
                it("should be the correct value") {
                    viewModel.currentPage = 1
                    expect(viewModel.isFirstPage).to(equal(true))
                    viewModel.currentPage = 2
                    expect(viewModel.isFirstPage).to(equal(false))
                }
            }

            context("isLastPage property") {
                it("should be the correct value") {
                    viewModel.currentPage = 10
                    viewModel.totalPages = 10
                    expect(viewModel.isLastPage).to(equal(true))
                    viewModel.currentPage = 1
                    expect(viewModel.isLastPage).to(equal(false))
                }
            }

            context("search function") {
                it("should search and update the properties") {
                    viewModel.searchTextDisplayed = "hello!"
                    viewModel.search()
                    expect(viewModel.searchTextUsed).toEventually(equal("hello!"))
                    expect(viewModel.currentPage).toEventually(equal(1))
                }
            }
            
            context("isFavorited function") {
                it("should return the correct value") {
                    viewModel.favoritedMovieIds = [100]
                    expect(viewModel.isFavorited(id: 90)).to(equal(false))
                    expect(viewModel.isFavorited(id: 100)).to(equal(true))
                }
            }
            
            context("changePage function") {
                it("should change the current page property") {
                    expect(viewModel.currentPage).to(equal(1))
                    viewModel.changePage(newPage: 2)
                    expect(viewModel.currentPage).toEventually(equal(2))
                }
            }
        }
    }
}

@testable import Movie_Browser
import XCTest
import Quick
import Nimble
import RealmSwift

final class RealmManagerTests: QuickSpec {
    override func spec() {
        let realmManager = RealmManager()
        let realm = try! Realm()
        
        describe("Testing RealmManager") {
            beforeEach {
                DispatchQueue.main.async {
                    realmManager.clearData()
                }
            }
            
            afterEach {
                DispatchQueue.main.async {
                    realmManager.clearData()
                }
            }
            
            context("getFavoritedMovieIds function") {
                it("should get the object") {
                    DispatchQueue.main.async {
                        let movie = FavoritedMovieModel(id: 10)
                        try! realm.write {
                            realm.add(movie)
                        }
                        
                        let ids = realmManager.getFavoritedMovieIds()
                        expect(ids.first!).to(equal(10))
                    }
                }
            }
            
            context("saveFavoritedMovieId function") {
                it("should save the object") {
                    DispatchQueue.main.async {
                        realmManager.saveFavoritedMovieId(id: 100)
                        let movies = realm.objects(FavoritedMovieModel.self)
                        let movieIds = movies.map({ $0.id })
                        expect(movieIds.first!).to(equal(100))
                    }
                }
            }
            
            context("deleteFavoritedMovieId function") {
                it("should delete the object") {
                    DispatchQueue.main.async {
                        realmManager.saveFavoritedMovieId(id: 50)
                        realmManager.deleteFavoritedMovieId(id: 50)
                        let ids = realmManager.getFavoritedMovieIds()
                        expect(ids).to(beEmpty())
                    }
                }
            }
            
            context("clearData function") {
                it("should delete all objects") {
                    DispatchQueue.main.async {
                        realmManager.saveFavoritedMovieId(id: 1)
                        realmManager.clearData()
                        let ids = realmManager.getFavoritedMovieIds()
                        expect(ids).to(beEmpty())
                    }
                }
            }
        }
    }
}

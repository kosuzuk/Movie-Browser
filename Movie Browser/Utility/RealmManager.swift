import RealmSwift

class RealmManager {
    let realm = try! Realm()
    
    func getFavoritedMovieIds() -> [Int] {
        let movies = realm.objects(FavoritedMovieModel.self)
        return movies.map({ $0.id })
    }
    
    func saveFavoritedMovieId(id: Int) {
        let movie = FavoritedMovieModel(id: id)
        try! realm.write {
            realm.add(movie)
        }
    }
    
    func deleteFavoritedMovieId(id: Int) {
        if let movie = realm.object(ofType: FavoritedMovieModel.self, forPrimaryKey: id) {
            try! realm.write {
                realm.delete(movie)
            }
        }
    }
    
    func clearData() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

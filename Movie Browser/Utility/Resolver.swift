import Swinject

struct Resolver {
    let container = Container()
    
    init() {
        // Register dependencies
        container.register(APICaller.self) { _ in APICaller() }
    }
    
    func getAPICaller() -> APICaller {
        // get an instance of APICaller
        return container.resolve(APICaller.self)!
    }
}

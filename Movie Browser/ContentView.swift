import SwiftUI
import Swinject

struct ContentView: View {
    var body: some View {
        VStack {
            SearchView(viewModel: SearchViewModel(apiCaller: Resolver().getAPICaller()))
        }
    }
}

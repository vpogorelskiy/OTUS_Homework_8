import Foundation
import MoviesApi
import Combine

class FavoritesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi: MoviesAPI
    private let favoritesStore: FavoritesStore
    
    private var cancellables = Set<AnyCancellable>()
    
    init(moviesApi: MoviesAPI,
         favorites: FavoritesStore = .shared) {
        self.moviesApi = moviesApi
        self.favoritesStore = favorites
        super.init()
        favorites.$favorites
            .assign(to: \.items, on: self)
            .store(in: &cancellables)
    }
    
    override func getMovies() {}
    
    override func getDetails(for item: BaseViewModelItem) {
        moviesApi.getMovieDetails(forImdbID: item.imdbID) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = dict?.mapValues{ "\($0)" }
        }
    }
}


import Foundation
import MoviesApi
import Combine

class FavoritesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private var _items: [BaseViewModelItem] = []
    
    private let moviesApi: MoviesAPI
    private let favoritesStore: FavoritesStore
    
    private var cancellables = Set<AnyCancellable>()
    
    init(moviesApi: MoviesAPI,
         favorites: FavoritesStore = .shared) {
        self.moviesApi = moviesApi
        self.favoritesStore = favorites
        super.init()
        
        favorites.$favorites
            .sink(receiveValue: { [weak self] newItems in
                self?._items = newItems
                self?.items = self?.filteredItems ?? []
            })
            .store(in: &cancellables)
    }
    
    private var filteredItems: [BaseViewModelItem] { return searchText.count > 0 ? _items.filter{ $0.title.contains(searchText) } : _items } 
    
    override func getMovies(_ query: String = "") {
        guard query.count > 0 else {
            items = favoritesStore.favorites
            return
        }
        items = filteredItems
    }
    
    override func getDetails(for item: BaseViewModelItem) {
        guard item.details == nil else { return }
        moviesApi.getMovieDetails(forImdbID: item.imdbID) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = dict?.mapValues{ "\($0)" }
        }
    }
}


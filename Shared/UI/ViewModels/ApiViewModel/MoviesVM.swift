import Foundation
import MoviesApi
import Combine
import CoreVideo

class MoviesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi: MoviesAPI
    private let favoritesStore: FavoritesStore
    
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    private var cancellables = Set<AnyCancellable>()
    
    init(moviesApi: MoviesAPI,
         favorites: FavoritesStore = .shared) {
        self.moviesApi = moviesApi
        self.favoritesStore = favorites
        super.init()
    }
    
    override func getMovies(_ query: String = "") {
        guard query.count > 0 else {
            items = []
            return
        }
        moviesApi.perform(query: query, batchSize: batchSize, startIndex: 0) { [weak self] movies, error in
            print("\(Self.self).\(#function): \(movies)")
            guard let self = self else { return }
            self.items.append(contentsOf: self.itemsFrom(movies: movies) )
        }
    }
    
    override func getNextIfNeeded(forItem item: BaseViewModelItem) {
        guard !isUpdating else { return }
        if items.last === item {
            isUpdating = true
            moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: lastBatchIndex + 1) { [weak self] movies, error in
                guard let self = self else { return }
                
                self.lastBatchIndex += 1
                self.isUpdating = false
                self.items.append(contentsOf: self.itemsFrom(movies: movies))
            }
        }
    }
    
    override func getDetails(for item: BaseViewModelItem) {
        guard let vmItem = item as? ViewModelApiItem else { return }
        moviesApi.getMovieDetails(forImdbID: vmItem.imdbID) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = dict?.mapValues{ "\($0)" }
        }
    }
    
    private func itemsFrom(movies: [MovieShort]) -> [BaseViewModelItem] {
        movies.map { movie in
            let item = ViewModelApiItem(movieShort: movie)
            item.isFavorite = isFavorite(item)
            item.favoriteChangeHandler = { [weak self] fav in
                self?.favoritesStore.setFavorite(movie: item)
            }
            return item
        }
    }
    
    func isFavorite(_ movie: BaseViewModelItem) -> Bool {
        return favoritesStore.favorites.firstIndex(where: { $0.imdbID == movie.imdbID }) != nil
    }
}

extension MoviesViewModel {
    class ViewModelApiItem: BaseViewModelItem  {
        init(movieShort: MovieShort) {
            super.init(title: movieShort.title ?? "",
                       imageUrl: movieShort.poster,
                       imdbID: movieShort.imdbID
            )
        }
        
        required init(from decoder: Decoder) throws {
            try super.init(from: decoder)
        }
    }
}

extension MovieRating: CustomStringConvertible {
    public var description: String { "\(source) : \(value)" }
}

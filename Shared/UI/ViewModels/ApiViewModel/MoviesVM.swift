
import Foundation
import MoviesApi

class MoviesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi: MoviesAPI
    
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    init(moviesApi: MoviesAPI, defaults: UserDefaults = .standard) {
        self.moviesApi = moviesApi
        super.init(defaults: defaults)
    }
    
    override func getMovies() {
        moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: 0) { [weak self] movies, error in
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
    
    func getDetails(for item: BaseViewModelItem) {
        guard let vmItem = item as? ViewModelApiItem else { return }
        moviesApi.getMovieDetails(for: vmItem.movieShort) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = dict?.mapValues{ "\($0)" }
        }
    }
    
    private func itemsFrom(movies: [MovieShort]) -> [BaseViewModelItem] {
        movies.map { movie in
            let item = ViewModelApiItem(movieShort: movie)
            item.isFavorite = isFavorite(item)
            item.favoriteChangeHandler = { [weak self] fav in
                self?.setFavorite(movie: item, isFavorite: fav)
            }
            return item
        }
    }
    
    func isFavorite(_ movie: BaseViewModelItem) -> Bool {
        let dict: [String: Bool] = defaults.dictionary(forKey: Constants.defaultsFavoritesKey) as? [String: Bool]  ?? [:]
        return dict[movie.imdbID] ?? false
    }
    
    func setFavorite(movie: BaseViewModelItem, isFavorite: Bool) {
        var dict: [String: Bool] = defaults.dictionary(forKey: Constants.defaultsFavoritesKey) as? [String: Bool]  ?? [:]
        dict[movie.imdbID] = isFavorite
        defaults.setValue(dict, forKey: Constants.defaultsFavoritesKey)
    }
}

extension MoviesViewModel {
    class ViewModelApiItem: BaseViewModelItem  {
        var movieShort: MovieShort
        
        init(movieShort: MovieShort) {
            self.movieShort = movieShort
            super.init(title: movieShort.title ?? "",
                       imageUrl: movieShort.poster,
                       imdbID: movieShort.imdbID
            )
        }
    }
}

extension MovieRating: CustomStringConvertible {
    public var description: String { "\(source) : \(value)" }
}

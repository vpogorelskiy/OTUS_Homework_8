
import Foundation
import MoviesApi
import CoreVideo

class MoviesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi: MoviesAPI
    private let defaults: UserDefaults
    
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    init(moviesApi: MoviesAPI, defaults: UserDefaults = .standard) {
        self.moviesApi = moviesApi
        self.defaults = defaults
        super.init()
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
            ViewModelApiItem(movieShort: movie,
                                     isFavorite: self.isFavorite(movie))
            { [weak self] fav in
                self?.setFavorite(movie: movie, isFavorite: fav)
            }
        }
    }
    
    private func isFavorite(_ movie: MovieShort) -> Bool {
        let dict: [String: Bool] = defaults.dictionary(forKey: Constants.defaultsFavoritesKey) as? [String: Bool]  ?? [:]
        return dict[movie.imdbID] ?? false
    }
    
    private func setFavorite(movie: MovieShort, isFavorite: Bool) {
        var dict: [String: Bool] = defaults.dictionary(forKey: Constants.defaultsFavoritesKey) as? [String: Bool]  ?? [:]
        dict[movie.imdbID] = isFavorite
        defaults.setValue(dict, forKey: Constants.defaultsFavoritesKey)
    }
}

extension MoviesViewModel {
    class ViewModelApiItem: BaseViewModelItem  {
        var movieShort: MovieShort
        
        init(movieShort: MovieShort,isFavorite: Bool, favoriteChangeHandler: @escaping (Bool) -> Void) {
            self.movieShort = movieShort
            super.init(title: movieShort.title ?? "",
                       imageUrl: movieShort.poster,
                       details: nil,
                       isFavorite: isFavorite,
                       favoriteChangeHandler: favoriteChangeHandler
            )
        }
    }
}

extension MovieRating: CustomStringConvertible {
    public var description: String { "\(source) : \(value)" }
}

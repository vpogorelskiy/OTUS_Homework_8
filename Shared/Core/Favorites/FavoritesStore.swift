import Foundation

class FavoritesStore {
    static let shared: FavoritesStore = .init()
    
    public var favorites: [BaseViewModelItem] = []
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        restoreFromDefaults()
    }
    
    func setFavorite(movie: BaseViewModelItem) {
        let existingIndex = favorites.firstIndex(where: { $0.imdbID == movie.imdbID })
        if movie.isFavorite, existingIndex == nil {
            favorites.append(movie)
        } else if !movie.isFavorite, let index = existingIndex {
            favorites.remove(at: index)
        }
        
        storeFavorites()
    }
    
    private func restoreFromDefaults() {
        if let data = defaults.value(forKey: Constants.defaultsFavoritesKey) as? Data {
            favorites = (try? JSONDecoder().decode([BaseViewModelItem].self, from: data)) ?? []
        }
    }
    
    private func storeFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            defaults.setValue(data, forKey: Constants.defaultsFavoritesKey)
        }
    }
}

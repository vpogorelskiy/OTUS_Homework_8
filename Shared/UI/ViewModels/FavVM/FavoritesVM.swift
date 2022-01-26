import Foundation
import MoviesApi

class FavoritesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi: MoviesAPI
    
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    init(moviesApi: MoviesAPI, defaults: UserDefaults = .standard) {
        self.moviesApi = moviesApi
        super.init(defaults: defaults)
    }
    
    override func getMovies() {
        
    }
    
    func getDetails(for item: BaseViewModelItem) {
        moviesApi.getMovieDetails(forImdbID: item.imdbID) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = dict?.mapValues{ "\($0)" }
        }
    }
}


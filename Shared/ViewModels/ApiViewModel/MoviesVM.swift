
import Foundation
import MoviesApi

class MoviesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi = MoviesAPI()
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    override func getMovies() {
        moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: 0) { [weak self] movies, error in
            print("\(Self.self).\(#function): \(movies)")
            self?.items.append(contentsOf: movies.map{ ViewModelApiItem(movieShort: $0) })
            
        }
    }
    
    override func getNextIfNeeded(forItem item: BaseViewModelItem) {
        guard !isUpdating else { return }
        if items.last === item {
            isUpdating = true
            moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: lastBatchIndex + 1) { [weak self] movies, error in
                self?.lastBatchIndex += 1
                self?.isUpdating = false
                self?.items.append(contentsOf: movies.map{ ViewModelApiItem(movieShort: $0) })
            }
        }
    }
    
    func getDetails(for item: BaseViewModelItem) {
        guard let vmItem = item as? ViewModelApiItem else { return }
        moviesApi.getMovieDetails(for: vmItem.movieShort) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = (dict as? [String: String]) ?? [:]
        }
    }
}

extension MoviesViewModel {
    class ViewModelApiItem: BaseViewModelItem  {
        var movieShort: MovieShort
        
        init(movieShort: MovieShort) {
            self.movieShort = movieShort
            super.init(title: movieShort.title ?? "",
                       imageUrl: movieShort.poster,
                       details: nil)
        }
    }
}

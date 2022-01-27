import Foundation
import MoviesApi

class BaseViewModel: ObservableObject {
    @Published var items: [BaseViewModelItem] = []
    
    func getMovies() {}
    func getDetails(for item: BaseViewModelItem) {}
    func getNextIfNeeded(forItem item: BaseViewModelItem) {}
}

class BaseViewModelItem: ObservableObject, Identifiable, Codable {
    enum CodingKeys: String, CodingKey {
            case title
            case imageUrl
            case imdbID
        }
    
    let title: String
    let imageUrl: String?
    let imdbID: String
    @Published var isFavorite: Bool = false {
        didSet { favoriteChangeHandler?(isFavorite) }
    }
    var favoriteChangeHandler: ((Bool) -> Void)? = nil
    @Published var details: [String: String]? = nil
    
    init(title: String,
         imageUrl: String?,
         imdbID: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.imdbID = imdbID
    }
}

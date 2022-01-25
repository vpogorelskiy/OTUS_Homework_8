import Foundation

class BaseViewModel: ObservableObject {
    @Published var items: [BaseViewModelItem] = []
    
    func getMovies() {}
    
    func getNextIfNeeded(forItem item: BaseViewModelItem) {}
}

class BaseViewModelItem: ObservableObject, Identifiable {
    var title: String
    var imageUrl: String?
    @Published var isFavorite: Bool {
        didSet { favoriteChangeHandler?(isFavorite) }
    }
    private let favoriteChangeHandler: ((Bool) -> Void)?
    @Published var details: [String: String]? {
        didSet {
            print("\(Self.self).\(#function): \(details)")
        }
    }
    
    init(title: String, imageUrl: String?, details: [String: String]?, isFavorite: Bool = false, favoriteChangeHandler: ((Bool) -> Void)? = nil) {
        self.title = title
        self.imageUrl = imageUrl
        self.details = details
        self.isFavorite = isFavorite
        self.favoriteChangeHandler = favoriteChangeHandler
    }
}

struct ViewModelDetailItem {
    public var title: String
    public var year: String?
    public var released: String?
    public var genre: String?
    public var director: String?
    public var writer: String?
    public var actors: String?
    public var plot: String?
    public var language: String?
    public var country: String?
    public var awards: String?
    public var posterUrl: URL?
    public var ratings: [String]
    public var type: String?
    public var website: URL?
    
}

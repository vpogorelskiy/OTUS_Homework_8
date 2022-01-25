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

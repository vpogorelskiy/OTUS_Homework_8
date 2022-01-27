import Foundation
import Combine

class BaseViewModel: ObservableObject {
    @Published var items: [BaseViewModelItem] = []
    @Published var searchText: String = "" { didSet { print("\(Self.self).\(#function): \(searchText)") }}
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.getMovies(value)
            })
            .store(in: &cancellables)
    }
    
    func getMovies(_ query: String = "") {}
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

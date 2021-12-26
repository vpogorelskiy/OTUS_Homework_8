import Foundation

class BaseViewModel: ObservableObject {
    @Published var items: [BaseViewModelItem] = []
    
    func getMovies() {}
    
    func getNextIfNeeded(forItem item: BaseViewModelItem) {}
}

class BaseViewModelItem: ObservableObject, Identifiable {
    var title: String
    var imageUrl: String?
    @Published var details: [String: String]?
    
    init(title: String, imageUrl: String?, details: [String: String]?) {
        self.title = title
        self.imageUrl = imageUrl
        self.details = details
    }
}

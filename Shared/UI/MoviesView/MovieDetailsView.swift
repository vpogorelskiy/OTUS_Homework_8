import Foundation
import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movie: BaseViewModelItem
    
    var body: some View {
        ScrollView{
            VStack {
                if let details = movie.details {
                    AsyncImage(url: URL(string: details["Poster"] ?? ""))
                    ForEach(Self.keysOrder, id: \.self) { key in
                        HStack {
                            Text(key)
                                .bold()
                                .frame(alignment: .leading)
                            Text(details[key] ?? "").italic()
                        }.focusable()
                    }
                } else {
                    Text("No movie details")
                }
            }
        }
    }
}

extension MovieDetailsView {
    private static let keysOrder: [String] = [
        "Plot",
        "Year",
        "Released",
        "Genre",
        "Actors",
        "Language",
        "Country",
        "Awards"
    ]
}

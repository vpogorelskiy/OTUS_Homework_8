import Foundation
import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var movie: BaseViewModelItem
    
    var body: some View {
        ScrollView{
            VStack {
                if let details = movie.details {
                    HStack {
                        Text(movie.title)
                        Spacer()
                        Button {
                            movie.isFavorite.toggle()
                        } label: {
                            Image(systemName: movie.isFavorite ? "suit.heart.fill" : "suit.heart")
                        }
                        .padding()
                        .buttonStyle(DefaultButtonStyle())
                    }
                    AsyncImage(url: URL(string: details["Poster"] ?? ""))
                    ForEach(Self.keysOrder, id: \.self) { key in
                        HStack {
                            Text(key)
                                .bold()
                                .frame(alignment: .leading)
                            Text(details[key] ?? "").italic()
                        }
                        #if os(tvOS)
                        .focusable()
                        #endif
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

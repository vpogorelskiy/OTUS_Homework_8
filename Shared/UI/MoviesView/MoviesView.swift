import Foundation
import SwiftUI

struct MoviesView: View {
    @ObservedObject var viewModel = MoviesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies) { item in
                    MoviesCell(item: item)
                        .onAppear {
                            viewModel.getNextIfNeeded(forItem: item)
                        }
                }
            }
            .navigationTitle("Fantasy movies")
            .onAppear {
                viewModel.getMovies()
            }
        }
    }
}

struct MoviesCell: View {
    @State var item: BaseViewModelItem
    
    var body: some View {
        NavigationLink {
            Text(item.title)
                .navigationTitle(item.title)
        } label: {
            HStack {
                if let urlString = item.imageUrl,
                    let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable(resizingMode: .tile)
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                }
                Text(item.title)
            }
        }
    }
}

import Foundation
import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.items) { item in
                NavigationLink {
                    MovieDetailsView(movie: item)
                        .onAppear {
                            viewModel.getDetails(for: item)
                        }
                } label: {
                    MoviesCell(item: item)
                        .onAppear {
                            viewModel.getNextIfNeeded(forItem: item)
                        }
                }
            }
        }
        .onAppear {
            viewModel.getMovies()
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
            .environmentObject(MockViewModel())
    }
}


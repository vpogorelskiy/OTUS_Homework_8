import Foundation
import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
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

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
            .environmentObject(MockViewModel())
    }
}


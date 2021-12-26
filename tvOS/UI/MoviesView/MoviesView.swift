import Foundation
import SwiftUI

struct MoviesView: View {
    @EnvironmentObject var viewModel: BaseViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(viewModel.items) { item in
                    MoviesCell(item: item)
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


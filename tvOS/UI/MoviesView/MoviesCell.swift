import Foundation
import SwiftUI

struct MoviesCell: View {
    @State var item: BaseViewModelItem
    
    var body: some View {
        NavigationLink {
            Text(item.title)
                .navigationTitle(item.title)
        } label: {
            VStack {
                if let urlString = item.imageUrl,
                    let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable(resizingMode: .stretch)
                    } placeholder: {
                        Color.gray
                    }
                }
                Text(item.title)
            }.frame(width: 500)
        }
    }
}

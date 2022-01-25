import Foundation
import SwiftUI

struct MoviesCell: View {
    @ObservedObject var item: BaseViewModelItem
    
    var body: some View {
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
            //                #if os(iOS)
            Button {
                item.isFavorite.toggle()
            } label: {
                Image(systemName: item.isFavorite ? "suit.heart.fill" : "suit.heart")
            }.focusable()
            //                #endif
        }
    }
}

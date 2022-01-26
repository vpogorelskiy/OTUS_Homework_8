import Foundation
import SwiftUI

struct MoviesCell: View {
    @ObservedObject var item: BaseViewModelItem
    @State var isFavFocused = false
    
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
        }
    }
}

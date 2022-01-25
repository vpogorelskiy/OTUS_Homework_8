import Foundation
import SwiftUI

struct MovieDetailsView: View {
    let movie: BaseViewModelItem
    
    var body: some View {
        VStack {
            if let details = movie.details {
                ForEach(details.sorted(by: >), id: \.key) { key, value in
                    HStack {
                        Text(key)
                        Text(value)
                    }
                }
            } else {
                Text("No movie details")
            }
        }
    }
}

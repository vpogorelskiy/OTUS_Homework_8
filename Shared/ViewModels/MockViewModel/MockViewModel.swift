import Foundation

class MockViewModel: BaseViewModel {
    override init() {
        super.init()
        items = [MockItem(title: Optional("Final Fantasy: The Spirits Within"), year: Optional("2001"), imdbID: "tt0173840", type: Optional("movie"), poster: Optional("https://m.media-amazon.com/images/M/MV5BOGNjZmNhYTYtMDE4OS00NjViLWEwNTQtZjQzOGY1M2MyYzhjXkEyXkFqcGdeQXVyMDM5ODIyNw@@._V1_SX300.jpg")),
                 MockItem(title: Optional("Final Fantasy VII: Advent Children"), year: Optional("2005"), imdbID: "tt0385700", type: Optional("movie"), poster: Optional("https://m.media-amazon.com/images/M/MV5BNTk4NjBhZTUtN2MwMy00MzIyLWFhN2ItMmUwYzQ4MWQxODM3L2ltYWdlL2ltYWdlXkEyXkFqcGdeQXVyMzM4MjM0Nzg@._V1_SX300.jpg")),
                 MockItem(title: Optional("Fantasy Island"), year: Optional("2020"), imdbID: "tt0983946", type: Optional("movie"), poster: Optional("https://m.media-amazon.com/images/M/MV5BOWE2ODZhYWYtNTFiYy00MjdmLWIzZGEtNTkyOTc1NDIwMjk4XkEyXkFqcGdeQXVyMzY0MTE3NzU@._V1_SX300.jpg")),
                 MockItem(title: Optional("Kingsglaive: Final Fantasy XV"), year: Optional("2016"), imdbID: "tt5595168", type: Optional("movie"), poster: Optional("https://m.media-amazon.com/images/M/MV5BOTEwNzMxNTU5M15BMl5BanBnXkFtZTgwMzMyMjg3OTE@._V1_SX300.jpg")),
                 MockItem(title: Optional("Final Fantasy VII"), year: Optional("1997"), imdbID: "tt0208155", type: Optional("game"), poster: Optional("https://m.media-amazon.com/images/M/MV5BMGMxZDliYTktZTRmYy00MDc5LTk1YjMtMGY4NTM4ZDYzYmY2XkEyXkFqcGdeQXVyNzUzNTQ2MjQ@._V1_SX300.jpg")),
                 MockItem(title: Optional("Fantasy Island"), year: Optional("1977–1984"), imdbID: "tt0077008", type: Optional("series"), poster: Optional("https://m.media-amazon.com/images/M/MV5BNjExMDcxMzkxNl5BMl5BanBnXkFtZTcwMDYwNDEzMQ@@._V1_SX300.jpg")),
                 MockItem(title: Optional("Final Fantasy X"), year: Optional("2001"), imdbID: "tt0284110", type: Optional("game"), poster: Optional("https://m.media-amazon.com/images/M/MV5BYTJhM2ZkZDAtNDA2Zi00OTJiLTgyOWEtZTExNWVlZWZkNzVkXkEyXkFqcGdeQXVyMTA3NjAwMDc4._V1_SX300.jpg")),
                 MockItem(title: Optional("Final Fantasy VIII"), year: Optional("1999"), imdbID: "tt0208156", type: Optional("game"), poster: Optional("https://m.media-amazon.com/images/M/MV5BMTUyMmRkOTQtMzRjNC00MTYyLWJlOTQtMDBhODIzZTI3MmMzXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_SX300.jpg")),
                 MockItem(title: Optional("Final Fantasy IX"), year: Optional("2000"), imdbID: "tt0249510", type: Optional("game"), poster: Optional("https://m.media-amazon.com/images/M/MV5BNTc4ZjkyODUtM2E0MC00MzVkLWJjYmQtZjQ5NjhjY2ZkNzA0XkEyXkFqcGdeQXVyMTA3NjAwMDc4._V1_SX300.jpg")),
                 MockItem(title: Optional("Final Fantasy XII"), year: Optional("2006"), imdbID: "tt0388944", type: Optional("game"), poster: Optional("https://m.media-amazon.com/images/M/MV5BMTM5MjYyNzQ3NF5BMl5BanBnXkFtZTcwMjM1OTE5Ng@@._V1_SX300.jpg"))
        ].map{ BaseViewModelItem(title: $0.title ?? "",
                                 imageUrl: $0.poster,
                                 details: nil) }
    }
}

struct MockItem {
    var title: String?
    var year: String?
    var imdbID: String
    var type: String?
    var poster: String?
}

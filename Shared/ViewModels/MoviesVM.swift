//
//  MoviesVM.swift
//  OTUS_Homework_8
//
//  Created by Вячеслав Погорельский on 21.12.2021.
//

import Foundation
import MoviesApi

class MoviesViewModel: BaseViewModel {
    @Published var isUpdating: Bool = false
    
    private let moviesApi = MoviesAPI()
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    func getMovies() {
        moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: 0) { [weak self] movies, error in
            self?.movies.append(contentsOf: movies.map{ ViewModelApiItem(movieShort: $0) })
        }
    }
    
    func getNextIfNeeded(forItem item: BaseViewModelItem) {
        guard !isUpdating else { return }
        if movies.last === item {
            isUpdating = true
            moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: lastBatchIndex + 1) { [weak self] movies, error in
                self?.lastBatchIndex += 1
                self?.isUpdating = false
                self?.movies.append(contentsOf: movies.map{ ViewModelApiItem(movieShort: $0) })
            }
        }
    }
    
    func getDetails(for item: BaseViewModelItem) {
        guard let vmItem = item as? ViewModelApiItem else { return }
        moviesApi.getMovieDetails(for: vmItem.movieShort) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = (dict as? [String: String]) ?? [:]
        }
    }
}

extension MoviesViewModel {
    class ViewModelApiItem: BaseViewModelItem  {
        var movieShort: MovieShort
        
        init(movieShort: MovieShort) {
            self.movieShort = movieShort
            super.init(title: movieShort.title ?? "",
                       imageUrl: movieShort.poster,
                       details: nil)
        }
    }
}

//
//  MoviesVM.swift
//  OTUS_Homework_8
//
//  Created by Вячеслав Погорельский on 21.12.2021.
//

import Foundation
import MoviesApi
import SwiftUI

protocol MovieItem {
    var title: String { get }
    var imageUrl: String? { get }
    var details: [String: String]? { get }
}

class MoviesViewModel: ObservableObject {
    @Published var movies: [MoviesViewModel.Item] = []
    @Published var isUpdating: Bool = false
    
    private let moviesApi = MoviesAPI()
    private var lastBatchIndex = 0
    private let batchSize = 5
    
    func getMovies() {
        moviesApi.perform(query: "Fantasy", batchSize: batchSize, startIndex: 0) { [weak self] movies, error in
            self?.movies.append(contentsOf: movies.map{ Item(movieShort: $0) })
        }
    }
    
    func getNextIfNeeded(forItem item: MoviesViewModel.Item) {
        guard !isUpdating else { return }
        if movies.last === item {
            isUpdating = true
            moviesApi.perform(query: "Cyberpunk", batchSize: batchSize, startIndex: lastBatchIndex + 1) { [weak self] movies, error in
                self?.lastBatchIndex += 1
                self?.isUpdating = false
                self?.movies.append(contentsOf: movies.map{ Item(movieShort: $0) })
            }
        }
    }
    
    func getDetails(for item: MoviesViewModel.Item) {
        moviesApi.getMovieDetails(for: item.movieShort) { movieFull, error in
            let dict = try? movieFull?.asDictionary() ?? [:]
            item.details = (dict as? [String: String]) ?? [:]
        }
    }
}

extension MoviesViewModel {
    class Item: MovieItem, ObservableObject {
        var title: String { return movieShort.title ?? ""}
        var imageUrl: String? { return movieShort.poster }
        let movieShort: MovieShort
        var details: [String: String]?
        
        init(movieShort: MovieShort) {
            self.movieShort = movieShort
        }
    }
}

extension MoviesViewModel.Item: Identifiable {}

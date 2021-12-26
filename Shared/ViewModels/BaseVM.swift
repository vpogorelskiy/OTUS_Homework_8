//
//  BaseVM.swift
//  OTUS_Homework_8
//
//  Created by Вячеслав Погорельский on 26.12.2021.
//

import Foundation

class BaseViewModel: ObservableObject {
    @Published var movies: [BaseViewModelItem] = []
}

class BaseViewModelItem: ObservableObject, Identifiable {
    var title: String
    var imageUrl: String?
    @Published var details: [String: String]?
    
    init(title: String, imageUrl: String?, details: [String: String]?) {
        self.title = title
        self.imageUrl = imageUrl
        self.details = details
    }
}

//
//  ModelController.swift
//  iOS14UIKitTour
//

import Foundation
import Combine

class ModelController {
    @Published var repositories = [Repository]()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        
    }
    
    func fetchRepos() {
        GithubAPI.fetchRepositories()
            .sink(receiveCompletion: { _ in }) { value in
                self.repositories = value
            }.store(in: &cancellables)
    }
}

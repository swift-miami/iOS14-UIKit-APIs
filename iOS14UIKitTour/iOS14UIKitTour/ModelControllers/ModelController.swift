//
//  ModelController.swift
//  iOS14UIKitTour
//

import Foundation
import Combine

class ModelController: ObservableObject {
    @Published var repositories = [Repository]() {
        didSet {
            print("heyyyy")
        }
    }
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchRepos()
    }
    
    func fetchRepos() {
        GithubAPI.fetch(.repositories)
            .sink(receiveCompletion: { _ in }) { (repositories: [Repository]) in
                self.repositories = repositories
                
                print("HERE")
            }
            .store(in: &cancellables)
    }
}

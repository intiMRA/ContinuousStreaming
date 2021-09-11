//
//  ViewModel.swift
//  EndlessStream
//
//  Created by Inti Albuquerque on 11/09/21.
//

import Foundation
import Combine

class ViewModel: ObservableObject {
    private let api: NamesAPI
    var alertContent: (title: String, message: String) = ("", "")
    @Published var name: String = ""
    @Published var showAlert = false
    private var cancellabe = Set<AnyCancellable>()
    
    init() {
        self.api = NamesAPI(names: [])
        
        $name
            .dropFirst()
            .flatMap(maxPublishers: .max(1)) { name in
                return self.api.saveName(name: name)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.alertContent = (error.title, error.message)
                    self.showAlert = true
                }
                
            }, receiveValue: {
                self.alertContent = ("Success", "The name was added to our database")
                self.showAlert = true
            })
            .store(in: &cancellabe)
    }
    
}

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
    @Published var submit: Void?
    private var cancellabe = Set<AnyCancellable>()
    
    init() {
        self.api = NamesAPI(names: [])
        $submit
            .dropFirst()
            .flatMap(maxPublishers: .max(1)) { _ -> AnyPublisher<NameError?, Never> in
                return self.api.saveName(name: self.name)
                    .map { _ in
                        nil
                    }
                    .catch { error in
                        Just(error)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .sink(receiveValue: { error in
                self.name = ""
                if let error = error {
                    self.alertContent = (error.title, error.message)
                    self.showAlert = true
                } else {
                    self.alertContent = ("Success", "The name was added to our database")
                    self.showAlert = true
                }
            })
            .store(in: &cancellabe)
    }
    
}

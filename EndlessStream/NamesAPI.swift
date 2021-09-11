//
//  NamesAPI.swift
//  EndlessStream
//
//  Created by Inti Albuquerque on 11/09/21.
//

import Foundation
import Combine

struct NameError: Error {
    let title: String
    let message: String
}

class NamesAPI {
    private var names: [String]
    init(names: [String]) {
        self.names = names
    }
    
    func saveName(name: String) -> AnyPublisher<Void, NameError> {
        Deferred {
            Future { promise in
                guard !self.names.contains(name) else {
                    promise(.failure(NameError(title: "Invalid Name", message: "The name \(name), is already in our server, no duplicates allowed")))
                    return
                }
                self.names.append(name)
                promise(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
}

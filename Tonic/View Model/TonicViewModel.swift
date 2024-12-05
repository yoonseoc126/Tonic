//
//  TonicViewModel.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import Foundation

class TonicViewModel: ObservableObject {
    
    static let shared = TonicViewModel()
    
    @Published var users: [Person]
    @Published var currentIndex = 0
    
    var currentUser : Person {
        users[currentIndex]
    }
    
    init() {
        users = [
        ]
    }
    
    // CRUD methods
    func create(id: Int, firstName: String, lastName: String, gender: String, birthday: String, bio: String, username: String, location: [Double], interests: [String], friends: [String]) {
        let user = Person(id: id, firstName: firstName, lastName: lastName, gender: gender, birthday: birthday, bio: bio, username: username, location: location, interests: interests, friends: friends)
        users.append(user)
    }
    
    func update(user: Person, at index: Int) {
        if index >= users.count || index < 0 {
            return
        }
        
        users[index] = user
    }
    
    func remove(at index: Int) {
        if index >= users.count || index < 0 {
            return
        }
        
        users.remove(at: index)
    }
}

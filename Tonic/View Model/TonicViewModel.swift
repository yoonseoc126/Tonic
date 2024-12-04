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
            Person(firstName: "Esther", lastName: "Kim", gender: "female", birthday: "07/27/2005", bio: "Hi, I'm Esther, Nice to meet you! I'm a sophomore at USC studying at IYA and I'd love to find new friends that have similar interests and hobbies.", username: "esther5727", location: [34.040000, -118.292230], interests: ["anime", "camping", "karaoke", "k-drama", "k-pop"], friends: ["renaewang", "philipkeem"]),
            Person(firstName: "Stephen", lastName: "Kim", gender: "male", birthday: "06/27/1998", bio: "Hi, I'm Stephen, I'm stinky", username: "stephen1234", location: [34.022350, -118.285118], interests: ["anime", "coffee", "karaoke"], friends: ["philipkeem"])
        ]
    }
    
    // CRUD methods
    func create(firstName: String, lastName: String, gender: String, birthday: String, bio: String, username: String, location: [Double], interests: [String], friends: [String]) {
        let user = Person(firstName: firstName, lastName: lastName, gender: gender, birthday: birthday, bio: bio, username: username, location: location, interests: interests, friends: friends)
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

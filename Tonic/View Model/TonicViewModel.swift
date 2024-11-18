//
//  TonicViewModel.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import Foundation

class TonicViewModel: ObservableObject {
    
    static let shared = TonicViewModel()
    
    // could have initialized up here, but nice to keep declaration short and separate
    @Published var users: [Person]
    @Published var currentIndex = 0
    
    var currentUser : Person {
        users[currentIndex]
    }
    
    init(){
        users = [
            Person(firstName: "Esther", lastName: "Kim", gender: "female", birthday: "07/27/2005", bio: "Hi, I'm Esther, Nice to meet you!", username: "esther5727", location: [1.012, 2.012], interests: ["anime", "camping", "karaoke"]),
            Person(firstName: "Stephen", lastName: "Kim", gender: "male", birthday: "06/27/1998", bio: "Hi, I'm Stephen, I'm stinky", username: "stephen1234", location: [1.012, 2.012], interests: ["anime", "coffee", "karaoke"])
        ]
        
        // CRUD - create, read, update, delete
        func create(firstName: String, lastName: String, gender: String, birthday: String, bio: String, username: String, location: [Float], interests: [String]) {
            let user = Person(firstName: firstName, lastName: lastName, gender: gender, birthday: birthday, bio: bio, username: username, location: location, interests: interests)
            users.append(user)
        }
        
        func update(user: Person, at index: Int) {
            // Defensive Programming
            // Early return pattern
            // Validation and protecting against bad input
            if index >= users.count || index < 0{
                return
            }
            
            users[index] = user
        }
        
        // allows for more intuitive accessing with keyword at
        func remove(at index: Int) {
            if index >= users.count || index < 0{
                return
            }
            
            users.remove(at: index)
        }
    }
}
    

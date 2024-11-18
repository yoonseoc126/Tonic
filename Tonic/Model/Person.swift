//
//  Person.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import Foundation

struct Person: Identifiable, Hashable{
    let id: UUID
    let firstName: String
    let lastName: String
    let gender: String
    let birthday: String
    let bio: String
    let username: String
    let location: [Float]
    let interests: [String]
    
    init(id: UUID,firstName: String, lastName: String, gender: String, birthday: String, bio: String, username: String, location: [Float], interests: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthday = birthday
        self.bio = bio
        self.username = username
        self.location = location
        self.interests = interests
    }
    
    init(firstName: String, lastName: String, gender: String, birthday: String, bio: String, username: String, location:[Float], interests: [String]) {
        id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthday = birthday
        self.bio = bio
        self.username = username
        self.location = location
        self.interests = interests
    }
}

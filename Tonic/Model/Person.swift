//
//  Person.swift
//  Tonic
//
//  Created by Student on 11/16/24.
//

import Foundation

struct Person: Identifiable, Hashable{
    let id: Int
    let firstName: String
    let lastName: String
    let gender: String
    let birthday: String
    let bio: String
    let username: String
    let location: [Double]
    let interests: [String]
    let friends: [String]
    
    init(id: Int, firstName: String, lastName: String, gender: String, birthday: String, bio: String, username: String, location: [Double], interests: [String], friends: [String]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.birthday = birthday
        self.bio = bio
        self.username = username
        self.location = location
        self.interests = interests
        self.friends = friends
    }
}

// Add to main App

func compareUserInterests(userId1: String, userId2: String, completion: @escaping (Int?) -> Void) {
    let db = Firestore.firestore()
    
    // Fetch the interests of the first user
    db.collection("users").document(userId1).getDocument { snapshot1, error1 in
        if let error1 = error1 {
            print("Error fetching user1's interests: \(error1)")
            completion(nil)
            return
        }
        
        guard let data1 = snapshot1?.data(), let interests1 = data1["interest"] as? [String] else {
            print("No interests found for user1.")
            completion(nil)
            return
        }
        
        // Fetch the interests of the second user
        db.collection("users").document(userId2).getDocument { snapshot2, error2 in
            if let error2 = error2 {
                print("Error fetching user2's interests: \(error2)")
                completion(nil)
                return
            }
            
            guard let data2 = snapshot2?.data(), let interests2 = data2["interest"] as? [String] else {
                print("No interests found for user2.")
                completion(nil)
                return
            }
            
            // Compare the interests
            let commonInterests = Set(interests1).intersection(Set(interests2))
            let commonCount = commonInterests.count
            
            // Determine the return value
            if commonCount <= 5 {
                completion(1)
            } else {
                completion(2)
            }
        }
    }
}


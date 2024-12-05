////
////  InterestsUpdate.swift
////  Tonic
////
////  Created by Mansur Tiyes on 02/12/2024.
////
//
//// THE ACTUAL FUNCTION FIRST:
//
//func saveInterestsToDatabase(userId: String, interests: Set<String>, completion: @escaping (Bool, String?) -> Void) {
//    let db = Firestore.firestore()
//    let interestsArray = Array(interests) // Convert Set to Array
//
//    db.collection("users").document(userId).setData(["interest": interestsArray], merge: true) { error in
//        if let error = error {
//            completion(false, "Failed to save interests: \(error.localizedDescription)")
//        } else {
//            completion(true, nil)
//        }
//    }
//}
//
//// In the Hobbies select, add to the next button:
//Button(action: {
//    let userId = tonicViewModel.currentUserId // Replace with your logic to fetch the current user ID
//    saveInterestsToDatabase(userId: userId, interests: interests) { success, errorMessage in
//        if success {
//            print("Interests saved successfully!")
//            dismiss() // Dismiss the view
//        } else if let errorMessage = errorMessage {
//            print("Error: \(errorMessage)")
//        }
//    }
//}) {
//    Image("NextButton")
//        .resizable()
//        .frame(width: 45, height: 45)
//}
//.disabled(interests.count < minimumInterests)
//.padding(30)
//
//
//

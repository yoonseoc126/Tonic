//
//  TonicApp.swift
//  Tonic
//
//  Created by Yoonseo Choi on 11/13/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TonicApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
        MapDiscovery(user: Person(id:1, firstName: "Esther", lastName: "Kim", gender: "female", birthday: "07/27/2005", bio: "Hi, I'm Esther, Nice to meet you! I'm a sophomore at USC studying at IYA and I'd love to find new friends that have similar interests and hobbies.", username: "esther5727", location: [34.040000, -118.292230], interests: ["anime", "camping", "karaoke", "k-drama", "k-pop"], friends: ["renaewang", "philipkeem"]))
            .environmentObject(TonicViewModel.shared)
    }
  }
}


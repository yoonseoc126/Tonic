//
//  TonicApp.swift
//  Tonic
//
//  Created by Yoonseo Choi on 11/13/24.
//

import SwiftUI
import FirebaseCore

<<<<<<< HEAD

@main
struct TonicApp: App {
    init() {
        // Configure Firebase only once
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MapView()
        }
=======

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
        SignInView()
>>>>>>> main
    }
  }
}


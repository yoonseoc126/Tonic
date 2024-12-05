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
    @StateObject private var tonicViewModel = TonicViewModel()

  var body: some Scene {
    WindowGroup {
        LoginScreen()
            .environmentObject(tonicViewModel)
    }
  }
}


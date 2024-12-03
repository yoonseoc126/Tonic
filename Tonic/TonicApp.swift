//
//  TonicApp.swift
//  Tonic
//
//  Created by Yoonseo Choi on 11/13/24.
//

import SwiftUI
import FirebaseCore


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
    }
}

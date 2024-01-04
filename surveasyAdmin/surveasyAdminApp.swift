//
//  surveasyAdminApp.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

@main
struct surveasyAdminApp: App {
    init() {
        FirebaseApp.configure()
    }
    // register app delegate for Firebase setup
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
    
}

// 요구 응답 수 수정 가능하게

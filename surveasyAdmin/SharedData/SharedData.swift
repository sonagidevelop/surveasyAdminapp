//
//  SharedData.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class UserSession : ObservableObject {
    static let shared = UserSession()
    private init() {
        print("UserSession Init")
    }
    let db = Firestore.firestore()
    @Published var SurveyNeedFetch : Bool = true
}

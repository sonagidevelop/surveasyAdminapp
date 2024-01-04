//
//  TestView.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import SwiftUI

struct TestView: View {
    @StateObject var viewModel = TestViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                viewModel.test()
            }
    }
}

class TestViewModel : ObservableObject {
    let db = UserSession.shared.db
    
    func test() {
        let surveyRef = db.collection("surveyData")
        surveyRef.order(by: "lastIDChecked").limit(to: 3)
            .getDocuments { snapshot, err in
                if let err = err {
                    print(err)
                }
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        print(document.data())
                    }
                }
            }
    }
    
}

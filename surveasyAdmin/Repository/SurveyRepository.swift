//
//  SurveyRepository.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import Foundation
import Firebase

class SurveyRepository : ObservableObject {
    static let shared = SurveyRepository()
    private init() { print("SurveyRepository Init")}
    
    @Published var surveys : [Survey] = []
    @Published var lastId : Int = 0
    
    func initialLoadSurvey() {
        SurveyRepository.shared.surveys = []
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "KST")
        let db = UserSession.shared.db
        let surveyRef = db.collection("surveyData")
        surveyRef.order(by: "id", descending: true).limit(to: 50)
            .getDocuments { snapshot, err in
                if let err = err {
                    print(err)
                }
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let data = document.data()
                        let timestamp = data["dueTimeTimeTime"] as? Timestamp
                        let survey = Survey(
                            docID : data["id"] as? Int ?? 0,
                            title: data["title"] as? String ?? "",
                            id: data["lastIDChecked"] as? Int ?? 0,
                            progress: data["progress"] as? Int ?? 0,
                            institute: data["institute"] as? String ?? "",
                            link: data["link"] as? String ?? "",
                            notice: data["notice"] as? String ?? "",
                            noticeToPanel: data["noticeToPanel"] as? String ?? "",
                            target: data["target"] as? String ?? "",
                            price: data["price"] as? Int ?? 0,
                            accountUserName: data["accountUserName"] as? String ?? "",
                            uploader: data["uploader"] as? String ?? "",
                            uploadDate: data["uploadDate"] as? String ?? "",
                            uploadTime: data["uploadTimeTime"] as? String ?? "",
                            spendTime: data["spendTime"] as? String ?? "",
                            dueDate: data["dueDate"] as? String ?? "",
                            dueTime: data["dueTimeTime"] as? String ?? "",
                            requiredCount: data["requiredHeadCount"] as? String ?? "",
                            rewardToPanel: data["panelReward"] as? Int ?? 0,
                            dueTimeDate: Date(timeIntervalSince1970: TimeInterval(timestamp?.seconds ?? 0)),
//                                .addingTimeInterval(TimeInterval(32400)),
                            respondedPanel: data["respondedPanel"] as? [String] ?? [],
                            targetingGender : data["targetingGender"] as? Int ?? 1,
                            targetingAgeOption: data["targetingAgeOption"] as? Int ?? 1,
                            targetingAgeOptionList: data["targetingAgeOptionList"] as? [String] ?? [],
                            uploaderEmail: data["uploaderEmail"] as? String ?? ""
                            
                        )
                        
                        DispatchQueue.main.async {
                            SurveyRepository.shared.surveys.append(survey)
                            UserSession.shared.SurveyNeedFetch = false
                        }
                    }
                }
            }
    }
    
    func editSurvey(changeToProgress2:Bool ,docId:Int, progress: Int, reward : Int, notice : String, link: String, date: Date, completion: @escaping () -> Void) {
        let db = UserSession.shared.db
        if changeToProgress2 {
            getLastIdChecked {
                //edit
                let field : [AnyHashable : Any] = [
                    "lastIDChecked" : SurveyRepository.shared.lastId,
                    "progress" : 2,
                    "panelReward" : reward,
                    "noticeToPanel" : notice,
                    "link" : link,
                    "dueDate" : date.DateToDateString(dateToFormat: date),
                    "dueTimeTime" : date.DateToTimeString(dateToFormat: date),
                    "dueTimeTimeTime" : Timestamp(date: date)
                ]
                self.updateData(field: field, docId: docId) {
                    print("updateSuccess")
                    UserSession.shared.SurveyNeedFetch = true
                    SurveyRepository.shared.increaseLastIdChecked()
                    completion()
                }
            }
        } else {
            let field : [AnyHashable : Any] = [
                "progress" : progress,
                "panelReward" : reward,
                "noticeToPanel" : notice,
                "link" : link,
                "dueDate" : date.DateToDateString(dateToFormat: date),
                "dueTimeTime" : date.DateToTimeString(dateToFormat: date),
                "dueTimeTimeTime" : Timestamp(date: date)]
            self.updateData(field: field, docId: docId) {
                print("updateSuccess")
                UserSession.shared.SurveyNeedFetch = true
                completion()
            }
        }
    }
    
    func getLastIdChecked(completion:@escaping () -> Void) {
        let db = UserSession.shared.db
        let ref = db.collection("lastID").document("lastIDChecked")
        ref.getDocument { snapshot, err in
            if let snapshot = snapshot {
                let data = snapshot.data()
                if let data = data {
                    let lastID : Int = data["lastIDChecked"] as? Int ?? 0
                    print(lastID)
                    SurveyRepository.shared.lastId = lastID
                    completion()
                }
            }
        }
    }
    
    func increaseLastIdChecked() {
        let db = UserSession.shared.db
        let ref = db.collection("lastID").document("lastIDChecked")
        ref.updateData([
            "lastIDChecked": FieldValue.increment(Int64(1))
        ])
    }
    
    func updateData(field: [AnyHashable : Any], docId:Int, completion: @escaping() -> Void) {
        let db = UserSession.shared.db
        let surveyRef = db.collection("surveyData").document("\(String(docId))")
        surveyRef.updateData(field) { err in
            if let err = err {
                print(err)
            } else {
                print("success")
                completion()
            }
        }
    }
    
    func getUploaderContact(email:String, completion: @escaping(String) -> Void) {
        print("getUploaderContact")
        let db = UserSession.shared.db
        let ref = db.collection("userData").document(email)
        ref.getDocument { snapshot, err in
            if let snapshot = snapshot {
                let data = snapshot.data()
                completion(data?["phoneNumber"] as? String ?? "연락처 없음")
                
            }
            if let err = err {
                print(err)
                completion("")
            }
        }
    }
    
    func deleteSurvey(docId:Int, completion:@escaping() -> Void) {
        print(#function)
        let db = UserSession.shared.db
        let ref = db.collection("surveyData").document("\(String(docId))")
        ref.delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                UserSession.shared.SurveyNeedFetch = true
                print("Document successfully removed!")
                completion()
            }
        }
    }
}

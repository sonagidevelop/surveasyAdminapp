//
//  SurveyModel.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import Foundation

struct Survey : Hashable {
    var docID : Int
    var title : String
    var id : Int //lastIDChecked
    var progress : Int
    var institute : String
    var link : String
    var notice : String
    var noticeToPanel : String
    var target : String
    var price : Int
    var accountUserName : String
    var uploader: String
    var uploadDate : String
    var uploadTime : String
    var spendTime : String
    var dueDate : String
    var dueTime : String
    var requiredCount : String
    var rewardToPanel : Int
    var dueTimeDate : Date
    var respondedPanel : [String]
    var targetingGender : Int
    var targetingAgeOption : Int
    var targetingAgeOptionList : [String]
    var uploaderEmail : String
}

enum TargetingGender : Int {
    case basic = 0
    case allGender = 1
    case male = 2
    case female = 3
    var genderString : String {
        switch self {
        case .basic:
            return "기본 옵션"
        case .allGender:
            return "전 연령"
        case .male:
            return "남성"
        case .female:
            return "여성"
        }
    }
}

enum SurveyProgress : Int {
    case BeforeCheck
    case ProgressOne
    case SurveyOngoing
    case SurveyDone
    case ReviewDone
    case DetailReviewDone
    var statusString : String {
        switch self {
        case .BeforeCheck:
            return "설문 검수 전"
        case .ProgressOne:
            return "progress1"
        case .SurveyOngoing:
            return "설문 진행 중"
        case .SurveyDone:
            return "설문 마감"
        case .ReviewDone:
            return "리뷰 작성 완료"
        case .DetailReviewDone:
            return "자세한 리뷰 작성 완료"
        }
    }
}

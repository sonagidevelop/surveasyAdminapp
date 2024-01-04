//
//  ReviewModel.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/06/04.
//

import Foundation

struct Review : Hashable {
    var id : Int
    var reviewGrade : Int
    var reviewDetail : String
    var title : String
}

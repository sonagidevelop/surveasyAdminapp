//
//  SurveyListViewModel.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import Foundation

class SurveyListViewModel : ObservableObject {
    @Published var surveys : [Survey] = []
    @Published var isLoading = false
    
    init() {
        SurveyRepository.shared.$surveys
            .assign(to: &$surveys)
    }
    
    func initialLoad() {
        if UserSession.shared.SurveyNeedFetch {
            print("Initial Load")
            SurveyRepository.shared.initialLoadSurvey()
        }
        
    }
    
    func loadMore() {
        
    }
}

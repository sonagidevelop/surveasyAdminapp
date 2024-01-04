//
//  MainViewModel.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import Foundation

class MainViewModel : ObservableObject {
    @Published var surveys : [Survey] = []
    
    init() {
        SurveyRepository.shared.$surveys
            .assign(to: &$surveys)
    }
    
        
}

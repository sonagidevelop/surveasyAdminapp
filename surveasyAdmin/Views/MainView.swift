//
//  ContentView.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel : MainViewModel = .init()
    
    var body: some View {
        NavigationView {
            TabView {
                ScrollView {
                    SurveyListView()
                }
                .tabItem {
                    Text("설문")
                }
                
                ReviewListView()
                .tabItem {
                    Text("리뷰")
                }
            }
            
            
        }
    }
}


//
//  SurveyListView.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/19.
//

import SwiftUI

struct SurveyListView: View {
    @StateObject var viewModel : SurveyListViewModel = .init()
    
    
    var body: some View {
        VStack {
            ForEach(viewModel.surveys, id:\.self) { i in
                NavigationLink {
                    SurveyDetailView(viewModel: SurveyDetailViewModel(survey: i))
                } label: {
                    SurveyListItem(survey: i)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                }
            }
            Button {
                viewModel.loadMore()
            } label: {
                Text("더 불러오기")
            }
            .disabled(viewModel.isLoading)

        }
        .onAppear {
            viewModel.initialLoad()
        }
    }
}

struct SurveyListItem : View {
    var survey : Survey
    var formattedPrice : String = ""
    
    var body: some View {
        VStack(spacing:8) {
            HStack {
                Text(SurveyProgress(rawValue: survey.progress)?.statusString ?? "")
                    .font(.system(size: 8))
                    .foregroundColor(.black.opacity(0.8))
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(.blue.opacity(0.2)))
                Spacer()
            }
            HStack {
                Text(survey.title)
                    .font(.system(size: 11))
                    .foregroundColor(.black)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("\(survey.price)원")
                    .font(.system(size: 11))
                    .foregroundColor(.black)
                    .bold()
            }
            HStack {
                HStack {
                    Text("LastID")
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                        .bold()
                    Text(String(survey.id))
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                        .bold()
                }
                .padding(.trailing,12)
                HStack {
                    Text("DocID")
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                        .bold()
                    Text(String(survey.docID))
                        .font(.system(size: 8))
                        .foregroundColor(.gray)
                        .bold()
                }
                Spacer()
                Text("주문자")
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .bold()
                Text(String(survey.uploader))
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
            }
            HStack {
                Text("주문일")
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .bold()
                Text(survey.uploadDate)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                Text(survey.uploadTime)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                Spacer()
                Text("마감일")
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .bold()
                Text(survey.dueDate)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                Text(survey.dueTime)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
            }
            HStack {
                Text("설문 소요시간")
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .bold()
                Text(survey.spendTime)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                Spacer()
                Text("응답수")
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .bold()
                Text(survey.requiredCount)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
            }
            HStack {
                Text("설문 대상")
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .bold()
                Text(survey.target)
                    .font(.system(size: 8))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(BackgroundColor(rawValue: survey.progress)?.background.opacity(0.2) ?? .blue.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10).stroke(BackgroundColor(rawValue: survey.progress)?.background ?? .blue, lineWidth: 3)
        )
    }
}
 
enum BackgroundColor : Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    var background : Color {
        switch self {
        case .zero:
            return Color.pink
        case .one:
            return Color.pink
        case .two:
            return Color.green
        case .three:
            return Color.black
        }
    }
}

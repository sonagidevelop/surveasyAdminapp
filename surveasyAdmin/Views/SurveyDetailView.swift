//
//  SurveyDetailView.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/05/24.
//

import SwiftUI

struct SurveyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel : SurveyDetailViewModel
    @FocusState private var focusItem: Bool
    
    
    var body: some View {
        ScrollView {
            Group {
                Text("")
                    .sheet(isPresented: $viewModel.showEditCheckSheet) {
                        EditDoneSheet(viewModel: viewModel)
                            .onDisappear {
                                if UserSession.shared.SurveyNeedFetch {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                }
                
                Text("")
                    .fullScreenCover(isPresented: $viewModel.showPhotoCheckView) {
                        PhotoCheckView(viewModel: PhotoCheckViewModel(id: String(viewModel.survey.id)))
                    }
            }
            
            VStack(alignment:.leading) {
                VStack(spacing:14) {
                    Text(viewModel.survey.title)
                        .bold()
                        .font(.system(size: 18))
                        .multilineTextAlignment(.leading)
                        .onAppear {
                            viewModel.fetchData()
                        }
                    // 프로그레스 바꾸기
                    // 설문 응답 비용 설정
                    // noticeToPanel 설정
                    // 링크 확인
                    HStack(alignment: .top) {
                        // left half
                        VStack(alignment: .leading, spacing: 14) {
                            VStack(alignment: .leading) {
                                VStack(alignment: .leading) {
                                    Text("ID")
                                        .font(.system(size: 12))
                                        .foregroundColor(.black)
                                        .bold()
                                    Text(String(viewModel.survey.id))
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("주문일")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                HStack {
                                    Text(viewModel.survey.uploadDate)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                    Text(viewModel.survey.uploadTime)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("설문 소요시간")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text(viewModel.survey.spendTime)
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("설문 대상")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text(viewModel.survey.target)
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.leading)
                            }
                            VStack(alignment: .leading) {
                                Text("선택한 성별 옵션")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text(TargetingGender(rawValue: viewModel.survey.targetingGender)?.genderString ?? "")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("주문자 연락처")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                //  Clickable telphone number
                                Link("\(viewModel.uploaderContact)", destination: URL(string: "sms://\(viewModel.uploaderContact)")!)
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("설문 링크")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Link(destination: (URL(string: viewModel.survey.link) ?? URL(string: "https://gosurveasy.com"))!) {
                                    Text(viewModel.survey.link)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                        Spacer()
                        // right hlaf
                        VStack(alignment:.leading, spacing: 14) {
                            VStack(alignment: .leading) {
                                Text("주문자")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text(String(viewModel.survey.uploader))
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("마감일")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                HStack {
                                    Text(viewModel.survey.dueDate)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                    Text(viewModel.survey.dueTime)
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("응답 수 / 요구 응답수")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text("\(viewModel.survey.respondedPanel.count) / \(viewModel.survey.requiredCount)")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("가격")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text("\(viewModel.survey.price)원")
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                            VStack(alignment: .leading) {
                                Text("선택한 연령 옵션")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                if viewModel.survey.targetingAgeOption == 1 {
                                    Text("연령 무관")
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                } else {
                                    Text(viewModel.survey.targetingAgeOptionList.joined(separator: ", "))
                                        .font(.system(size: 10))
                                        .foregroundColor(.gray)
                                }
                            }
                            VStack(alignment: .leading) {
                                Text("설문 리워드")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                Text(String(viewModel.survey.rewardToPanel))
                                    .font(.system(size: 10))
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                    }
                    
                }
                .padding(12)
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.gray.opacity(0.15))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10).stroke(Color.black)
                )
                
                VStack(alignment:.leading, spacing: 14) {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("리워드 금액")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                TextField("리워드", value: $viewModel.rewardToPanel, formatter: NumberFormatter())
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                    .focused($focusItem)
                                    .frame(width: 70)
                                    .onChange(of: viewModel.rewardToPanel) { newValue in
                                        viewModel.editedInfos[0] = "리워드 변경 -> \(String(newValue))원"
                                        viewModel.isRewardEdited = true
                                    }
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Progress")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .bold()
                                HStack {
                                    Button {
                                        viewModel.progress = 0
                                    } label: {
                                        Text("0")
                                            .font(.system(size: 12))
                                            .foregroundColor(.black)
                                            .bold()
                                            .padding(viewModel.progress == 0 ? 10 : 6)
                                            .background(Circle().foregroundColor(viewModel.progress == 0 ? .green.opacity(0.7) :.black.opacity(0.2)))
                                    }
                                    .onChange(of: viewModel.progress) { newValue in
                                        viewModel.editedInfos[4] = "Progress 변경 -> \(String(newValue))"
                                    }
                                    Button {
                                        viewModel.progress = 2
                                    } label: {
                                        Text("2")
                                            .font(.system(size: 12))
                                            .foregroundColor(.black)
                                            .bold()
                                            .padding(viewModel.progress == 2 ? 10 : 6)
                                            .background(Circle().foregroundColor(viewModel.progress == 2 ? .green.opacity(0.7) :.black.opacity(0.2)))
                                    }
                                    .onChange(of: viewModel.progress) { newValue in
                                        viewModel.editedInfos[4] = "Progress 변경 -> \(String(newValue))"
                                    }
                                    Button {
                                        viewModel.progress = 3
                                    } label: {
                                        Text("3")
                                            .font(.system(size: 12))
                                            .foregroundColor(.black)
                                            .bold()
                                            .padding(viewModel.progress == 3 ? 10 : 6)
                                            .background(Circle().foregroundColor(viewModel.progress == 3 ? .green.opacity(0.7) :.black.opacity(0.2)))
                                    }
                                    .onChange(of: viewModel.progress) { newValue in
                                        viewModel.editedInfos[4] = "Progress 변경 -> \(String(newValue))"
                                    }

                                }
                            }
                            
                        }
                        
                    }
                    VStack(alignment: .leading) {
                        Text("패널 유의사항")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .bold()
                        TextField("유의사항 없음", text: $viewModel.noticeToPanel)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusItem)
                            .onChange(of: viewModel.noticeToPanel) { newValue in
                                viewModel.editedInfos[1] = "유의사항 변경 -> \(newValue)"
                            }
                        Text("고객이 작성한 notice: \(viewModel.survey.notice)")
                            .font(.system(size: 8))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.leading)
                    }
                    VStack(alignment: .leading) {
                        Text("설문 링크 수정")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .bold()
                        TextField("링크", text: $viewModel.editedLink)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusItem)
                            .onChange(of: viewModel.editedLink) { newValue in
                                viewModel.editedInfos[2] = "설문 링크 변경"
                            }
                    }
                    VStack(alignment: .leading) {
                        Text("마감 기한")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                            .bold()
                        DatePicker("마감", selection: $viewModel.editedDate)
                            .labelsHidden()
                            .onChange(of: viewModel.editedDate) { newValue in
                                viewModel.editedInfos[3] = "마감기한 변경 -> \(viewModel.dateFormatter.string(from: newValue))"
                            }
//                            .environment(\.timeZone, TimeZone(abbreviation: "KST") ?? .current)
//                            .border(Color.gray)
                        HStack {
                            Spacer()
                            Text(.init("마감기한이 **\(viewModel.dateFormatter.string(from: viewModel.editedDate))**로 설정됩니다."))
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                    HStack {
                        Button {
                            viewModel.showPhotoCheckView = true
                        } label: {
                            Image(systemName:"camera")
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green.opacity(0.6)))
                        }

                        Spacer()
                        Button {
                            viewModel.showEditDoneSheet()
                        } label: {
                            Text("수정 완료")
                                .bold()
                                .font(.system(size: 14))
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green.opacity(0.6)))
                        }
                        Spacer()
                        Button {
                            viewModel.showDeleteAlert = true
                        } label: {
                            Image(systemName: "trash.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.red.opacity(0.6))
                        }
                        .alert("설문 삭제 맞아요?", isPresented: $viewModel.showDeleteAlert) {
                            Button("맞습니다", role: .destructive) {
                                viewModel.deleteSurvey(docId: viewModel.survey.docID) {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
        .padding(12)
        .onTapGesture {
            focusItem = false
        }
        
        
        
    }
}

struct EditDoneSheet : View {
    @ObservedObject var viewModel : SurveyDetailViewModel
    @Environment(\.presentationMode) var presentationMode
    var changeToProgress2 : Bool {
        return viewModel.progress == 2 && viewModel.survey.progress != 2
    }
    
    var body: some View {
        VStack {
            Text("수정 내용을 확인해주세요")
                .bold()
                .font(.system(size: 30))
                .padding(.top, 20)
            Spacer()
            if changeToProgress2 {
                Text("Progress 2로 변경됩니다!!!")
                    .bold()
                    .foregroundColor(.red)
            }
            Text(viewModel.survey.title)
                .bold()
                .font(.system(size: 20))
            VStack(alignment: .leading) {
                ForEach(viewModel.editedInfos, id:\.self) { info in
                    Text(info)
                }
            }
            Spacer()
            Button {
                viewModel.editDone(changeToProgress2: changeToProgress2, docId: viewModel.survey.docID, progress: viewModel.progress, reward: viewModel.rewardToPanel, notice: viewModel.noticeToPanel, link: viewModel.editedLink, date: viewModel.editedDate) {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text("수정 완료")
                    .bold()
                    .font(.system(size: 16))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green.opacity(0.6)))
            }

        }
    }
}



class SurveyDetailViewModel : ObservableObject {
    @Published var rewardToPanel : Int
    @Published var noticeToPanel : String
    @Published var editedLink : String
    @Published var editedDate : Date
    @Published var editedInfos : [String] = ["","","","","",""]
    @Published var progress : Int
    @Published var requiredHeadCount : String
    @Published var showEditCheckSheet = false
    @Published var showPhotoCheckView = false
    @Published var showDeleteAlert = false
    @Published var isRewardEdited = false
    @Published var uploaderContact = ""
    
    
    var survey : Survey
    var dateFormatter : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")!
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    init(survey:Survey) {
        self.survey = survey
        self.editedLink = survey.link
        self.editedDate = survey.dueTimeDate
        self.rewardToPanel = survey.rewardToPanel
        self.noticeToPanel = survey.noticeToPanel
        self.progress = survey.progress
        self.requiredHeadCount = survey.requiredCount
    }
    
    
    
    func fetchData() {
        DispatchQueue.main.async {
            self.rewardToPanel = self.survey.rewardToPanel
            self.noticeToPanel = self.survey.noticeToPanel
            self.editedLink = self.survey.link
            self.editedDate = self.survey.dueTimeDate
            SurveyRepository.shared.getUploaderContact(email: self.survey.uploaderEmail) { contact in
                self.uploaderContact = contact
            }
            
        }
         
    }
    
    func showEditDoneSheet() {
        DispatchQueue.main.async {
            self.showEditCheckSheet = true
        }
    }
    
    func editDone(changeToProgress2 : Bool, docId : Int,progress:Int,reward:Int,notice:String,link:String,date:Date,completion:@escaping () -> Void) {
        SurveyRepository.shared.editSurvey(changeToProgress2: changeToProgress2, docId: docId, progress: progress, reward: reward, notice: notice, link: link, date: date) {
            completion()
        }
    }
    
    func deleteSurvey(docId: Int, completion: @escaping() -> Void) {
        SurveyRepository.shared.deleteSurvey(docId: docId) {
            completion()
        }
    }
}


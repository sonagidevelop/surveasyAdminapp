//
//  ReviewListView.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 2023/06/04.
//

import SwiftUI
import Firebase

struct ReviewListView: View {
    @StateObject var viewModel : ReviewListViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.reviews, id: \.self) { review in
                    ReviewItem(id: review.id, reviewGrade: review.reviewGrade, reviewDetail: review.reviewDetail, title: review.title)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
            }
        }
        .onAppear {
            viewModel.fetchReviews()
        }
    }
}

struct ReviewItem : View {
    var id : Int
    var reviewGrade : Int
    var reviewDetail : String
    var title : String
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(String(id))
                Spacer()
                ForEach(0..<reviewGrade) { _ in
                    Image(systemName: "star.fill")
                        .foregroundColor(.green.opacity(0.5))
                }
            }
            .padding(.horizontal, 8)
            Text(title)
                .bold()
            
            Text(reviewDetail)
            
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.green.opacity(0.2)))
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView()
    }
}

class ReviewListViewModel : ObservableObject {
    @Published var reviews : [Review] = []

    func fetchReviews() {
        let db = UserSession.shared.db
        let ref = db.collection("reviewData")
        ref
            .getDocuments { snapshot, err in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let review = Review(
                        id: Int(data["id"] as? String ?? "0") ?? 0,
                        reviewGrade: data["reviewGrade"] as? Int ?? 0,
                        reviewDetail: data["reviewDetail"] as? String ?? "",
                        title: data["title"] as? String ?? "")
                    DispatchQueue.main.async {
                        self.reviews.append(review)
                        self.reviews = self.reviews.sorted(by: {$0.id > $1.id})
                    }
                }
            }
        }
    }
}

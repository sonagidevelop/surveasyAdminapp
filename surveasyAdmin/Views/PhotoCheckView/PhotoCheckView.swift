//
//  PhotoCheckView.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 12/9/23.
//

import SwiftUI
import FirebaseStorage

struct PhotoCheckView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel : PhotoCheckViewModel
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        VStack {
            Text("aa")
                .onAppear {
                    viewModel.getPictures()
                }
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            ScrollView {
//                ForEach(0..<viewModel.imgs.count, id:\.self) { i in
//                    Image(uiImage: viewModel.imgs[i])
//                        .resizable()
//                        .scaledToFit()
//                }
                
                LazyVGrid(columns: columns, content: {
                    ForEach(0..<viewModel.imgs.count, id:\.self) { i in
                        Image(uiImage: viewModel.imgs[i])
                            .resizable()
                            .frame(width: 70, height: 150)
                    }
                })
            }
        }
    }
}

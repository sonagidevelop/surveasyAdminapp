//
//  PhotoCheckViewModel.swift
//  surveasyAdmin
//
//  Created by Jin Hyeok Choi on 12/9/23.
//

import Foundation
import FirebaseStorage
import UIKit

class PhotoCheckViewModel : ObservableObject {
//    let storage = Storage.storage()
//    let storageRef = storage.reference()
    var id : String
    @Published var imgs : [UIImage] = []
    
    
    init(id:String) {
        self.id = id
    }
//    let imageRef = Storage.storage().reference().child("962/")
    
//    func downSampleImg() {
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//          if let error = error {
//            // Uh-oh, an error occurred!
//              print("asdf")
//              print(error)
//          } else {
//              print("image")
//            // Data for "images/island.jpg" is returned
//            let image = UIImage(data: data!)
//              DispatchQueue.main.async {
//                  self.img = image
//              }
//          }
//        }
//    }
    
    func getPictures() {
        print("get")
//        self.isLoading = true
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let path : String = "\(id)/"
        let imgRef = storageRef.child(path)
        imgRef.listAll { result, err in
            if let result = result {
                for prefixe in result.prefixes {
                }
                for item in result.items {
                    item.getData(maxSize: 1 * 1024 * 1024) { data, err in
                        if let err = err {
                            print(err)
                        } else {
                            if let data = data {
                                let image = UIImage(data: data)
                                guard let img = image else {return}
                                DispatchQueue.main.async {
                                    self.imgs.append(img)
//                                    self.isLoading = false
                                    print(self.imgs.count)
                                }
                            }
            
                        }
                    }
                }
            }
        }
    }
}

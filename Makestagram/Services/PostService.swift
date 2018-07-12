//
//  PostService.swift
//  Makestagram
//
//  Created by Ben Botvinick on 7/11/18.
//  Copyright © 2018 Ben Botvinick. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage) {
        let imageRef = StorageReference.newPostImageReference()
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }
            
            let urlString = downloadURL.absoluteString
            let aspectHeight = image.aspectHeight
            create(forURLString: urlString, aspectHeight: aspectHeight, image: image)
        }
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat, image: UIImage) {
        let currentUser = User.current
        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
        MLService.evaluateImage(for: image, post: post, completionHandler: { (post) in
            let dict = post.dictValue
            let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
            postRef.updateChildValues(dict)
        })
    }
}

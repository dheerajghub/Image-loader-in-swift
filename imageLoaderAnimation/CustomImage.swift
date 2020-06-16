//
//  CustomImage.swift
//  imageLoaderAnimation
//
//  Created by Dheeraj Kumar Sharma on 15/06/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit

protocol loadImageDelegate {
    func didFinishLoading(_ s:CustomImage)
}

class CustomImage {
    
    var imgURL:String
    var image:UIImage?
    var delegate:loadImageDelegate?
    
    init(imgURL:String) {
        self.imgURL = imgURL
    }
    
    func loadImage() {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let imageURL = URL(string: self.imgURL)
            let imageData = NSData(contentsOf: imageURL!)
            self.image = UIImage(data: imageData! as Data)
            DispatchQueue.main.async {
                self.didLoadImage()
            }
        }
    }
    
    func didLoadImage(){
        delegate?.didFinishLoading(self)
    }
}

//
//  ViewController.swift
//  imageLoaderAnimation
//
//  Created by Dheeraj Kumar Sharma on 15/06/20.
//  Copyright © 2020 Dheeraj Kumar Sharma. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController, loadImageDelegate {

    var customImage:CustomImage?
    lazy var cardView:UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.cornerRadius = 20
        v.dropShadow(scale: true)
        return v
    }()
    
    let imageLoaderView:AnimationView = {
        let v = AnimationView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        return v
    }()
    
    let loadImageView:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cardView)
        cardView.addSubview(imageLoaderView)
        cardView.addSubview(loadImageView)
        imageLoaderView.isHidden = false
        setUpConstraints()
        customImage = CustomImage(imgURL: "https://i.picsum.photos/id/866/400/400.jpg?hmac=oHJBlOQwtaF75oX43dFtPf4At_GRLEx9FQqkkfpLR5U")
        customImage?.loadImage()
        customImage?.delegate = self
        
        //MARK:- Loading animation
        imageLoaderView.animation = Animation.named("loader")
        imageLoaderView.loopMode = LottieLoopMode.loop
        imageLoaderView.play()
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 400),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            imageLoaderView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageLoaderView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            imageLoaderView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -40),
            imageLoaderView.topAnchor.constraint(equalTo: cardView.topAnchor),
            
            loadImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            loadImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            loadImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            loadImageView.topAnchor.constraint(equalTo: cardView.topAnchor)
        ])
    }
    
    func didFinishLoading(_ s: CustomImage) {
        imageLoaderView.isHidden = true
        loadImageView.image = customImage?.image
        imageLoaderView.stop()
    }
    
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = .zero
        layer.shadowRadius = 15
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

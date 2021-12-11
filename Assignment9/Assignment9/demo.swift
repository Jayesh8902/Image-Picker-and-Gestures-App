//
//  demo.swift
//  Assignment9
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class demo: UIViewController {
    private let myView :UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 20, y: 100, width: 400 - 70, height: 200)
        return view
    }()
    private let lblheading : UILabel = {
        let lbl = UILabel()
        lbl.text = """
        Select Image By Clicking
        Above Grey Area
        """
        lbl.font = UIFont(name : "Arial", size: 20)
        lbl.numberOfLines = 2
        lbl.textAlignment = .center
        return lbl
    }()
    private let imagepick:UIImagePickerController = {
        let ip = UIImagePickerController()
        ip.allowsEditing = true
        return ip
    }()
    private let img:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named : "")
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myView)
        imagepick.delegate = self
        myView.addSubview(img)
        view.addSubview(lblheading)
        
        //Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        myView.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(didPinchView))
        view.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotationView))
             view.addGestureRecognizer(rotationGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        view.addGestureRecognizer(panGesture)
        

    }
    override func viewDidLayoutSubviews() {
        img.frame = CGRect(x: 0, y: 0, width: myView.frame.size.width, height: myView.frame.size.height)
       lblheading.frame = CGRect(x: 0, y: 450, width: view.frame.size.width, height: 100)
    }
}

extension demo : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImg = info[.editedImage] as? UIImage{
            img.image = selectedImg
        }
        picker.dismiss(animated: true)
    }
}


//gesture
extension demo {
    
    @objc private func didTapView(gesture: UITapGestureRecognizer) {
        imagepick.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.imagepick,animated: true)
        }
    }
    
    @objc private func didPinchView(gesture: UIPinchGestureRecognizer) {
                myView.backgroundColor = .clear
                myView.transform = CGAffineTransform(scaleX: gesture.scale,y: gesture.scale)
    }

    @objc private func didRotationView(gesture: UIRotationGestureRecognizer) {
                myView.backgroundColor = .clear
                myView.transform=CGAffineTransform(rotationAngle: gesture.rotation)
    }
    @objc private func didSwipeView(gesture: UISwipeGestureRecognizer) {
        
        if gesture.direction == .left {
            UIView.animate(withDuration: 0.5) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x - 40, y: self.myView.frame.origin.y, width: 200, height: 200)
            }
        } else if gesture.direction == .right {
            UIView.animate(withDuration: 0.5) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x + 40, y: self.myView.frame.origin.y, width: 200, height: 200)
            }
        } else if gesture.direction == .up {
            UIView.animate(withDuration: 0.5) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x - 40, y: self.myView.frame.origin.y - 40, width: 200, height: 200)
            }
        } else if gesture.direction == .down {
            UIView.animate(withDuration: 0.5) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x - 40, y: self.myView.frame.origin.y + 40, width: 200, height: 200)
            }
        }
        
        
    }

    @objc private func didPanView(gesture: UIPanGestureRecognizer) {
     let x=gesture.location(in : view).x
     let y = gesture.location(in : view).y
     
     myView.center = CGPoint(x: x, y: y)
     
     }
    

}

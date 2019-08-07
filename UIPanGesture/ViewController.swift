//
//  ViewController.swift
//  UIPanGesture
//
//  Created by Brendan Milton on 07/08/2019.
//  Copyright © 2019 Brendan Milton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    // Outlets
    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addPanGesture(view: fileImageView)
        
        // Get original placement of imageView
        fileViewOrigin = fileImageView.frame.origin
        
        // Bring image to front (Top layer)
        view.bringSubviewToFront(fileImageView)
    }
    
    func addPanGesture(view: UIView){
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer){
        
        let fileView = sender.view!
        
        // Handle gesture state
        switch sender.state {
        case .began, .changed:
            
           moveViewWithPan(view: fileView, sender: sender)
            
        case .ended:
            
            // If file CGRect (Frame) touches Trash CGRect (Frame) do..
            if fileView.frame.intersects(trashImageView.frame) {
                
                deleteView(view: fileView)
                
            } else {
                
                returnViewToOrigin(view: fileView)
            }
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer){
        
        // Translation tracks movement and velocity of pan
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func returnViewToOrigin(view: UIView){
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin = self.fileViewOrigin
        })
        
    }
    
    func deleteView(view: UIView){
     
        UIView.animate(withDuration: 0.3, animations: {
            view.alpha = 0.0
        })
    }
}


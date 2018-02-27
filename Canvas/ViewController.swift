//
//  ViewController.swift
//  Canvas
//
//  Created by Kyle Ohanian on 2/27/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var newlyCreatedHeight: CGFloat!
    var newlyCreatedWidth: CGFloat!
    
    var clickedY: CGFloat!
    var clickedX: CGFloat!
    
    var views: [UIView]!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        views = []
        trayOriginalCenter = trayView.center
        trayDownOffset = 160
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
        let tap = UITapGestureRecognizer(target: self, action: #selector(canvasTapped))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
//        var velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Gesture began")
            trayOriginalCenter = trayView.center

        }
        else if sender.state == .changed {
            print("Gesture is changing")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)

        }
        else if sender.state == .ended {
            print("Gesture ended")
        }
    }
    
    @objc func didPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Gesture began")
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            newlyCreatedFace.center = newlyCreatedFaceOriginalCenter
            newlyCreatedWidth = newlyCreatedFace.frame.size.width
            newlyCreatedHeight = newlyCreatedFace.frame.size.height
            let newx = newlyCreatedFace.frame.origin.x
            let newy = newlyCreatedFace.frame.origin.y
            let newwidth = newlyCreatedFace.frame.size.width * 4 / 3
            let newheight = newlyCreatedFace.frame.size.height * 4 / 3
            newlyCreatedFace.frame = CGRect(x: newx, y: newy, width: newwidth, height: newheight)
        }
        else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else if sender.state == .ended {
            print("Gesture ended")
            let newx = newlyCreatedFace.frame.origin.x
            let newy = newlyCreatedFace.frame.origin.y
            let newwidth = newlyCreatedFace.frame.size.width * 3 / 4
            let newheight = newlyCreatedFace.frame.size.height * 3 / 4
            newlyCreatedFace.frame = CGRect(x: newx, y: newy, width: newwidth, height: newheight)
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            print("Gesture began")
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            newlyCreatedFace.center = imageView.center
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(sender:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFace.center.x += trayView.frame.origin.x
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            tap.numberOfTapsRequired = 2
            newlyCreatedFace.addGestureRecognizer(tap)
        }
        else if sender.state == .changed {
            print("Gesture is changing")
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else if sender.state == .ended {
            print("Gesture ended")
            views.append(newlyCreatedFace)
        }
        
    }
    
    @objc func doubleTapped(sender: UITapGestureRecognizer) {
        print("Double Tapped")
        sender.view?.removeFromSuperview()
    }
    
    @objc func canvasTapped(sender: UITapGestureRecognizer) {
        print("Double Tapped Canvas")
        for coolView in views {
            coolView.removeFromSuperview()
        }
        views.removeAll()
    }
    
    
}


//
//  ViewController.swift
//  Jolteon
//
//  Created by Dylan Straughan on 6/24/16.
//  Copyright © 2016 Dylan Straughan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var powerButton: UIButton!
    var panGestureRecognizer:UIPanGestureRecognizer!
    var center:CGPoint {
        return view.center
    }
    var lastColor:UIColor = UIColor.whiteColor()
    var status:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.didPan(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.delegate = self
        panGestureRecognizer.enabled = false
        
        view.backgroundColor = UIColor.blackColor()
        
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if status { //light is on
            
            status = false
            panGestureRecognizer.enabled = false
            APIClient.post(rgb(UIColor.blackColor(), status: status))
            
            UIView.animateWithDuration(0.5, animations: {
                self.view.backgroundColor = UIColor.blackColor()
                self.view.layoutIfNeeded()
            })
            
        } else { // light is off
            
            status = true
            panGestureRecognizer.enabled = true
            lastColor = UIColor.whiteColor()
            APIClient.post(rgb(lastColor, status: status))
            
            UIView.animateWithDuration(0.5, animations: {
                self.view.backgroundColor = self.lastColor
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didPan(gestureRecognizer:UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            print(angleForPoint(gestureRecognizer.locationInView(view)))
            view.backgroundColor = UIColor(hue: angleForPoint(gestureRecognizer.locationInView(view)), saturation: 1, brightness: 1, alpha: 1)
            if let color = view.backgroundColor {
                lastColor = color
                APIClient.post(rgb(lastColor, status: status))
            }
        }
    }
    
    func angleForPoint(point:CGPoint) -> CGFloat {
        var angle = CGFloat(-atan2f(Float(point.x - center.x), Float(point.y - center.y))) + CGFloat(M_PI)/2
        
        
        if (angle < 0) {
            angle += CGFloat(M_PI)*2;
        }
        
        angle = angle/CGFloat(M_PI)/2
        
        return angle
    }
    
    func rgb(color:UIColor, status:Bool) -> [String: AnyObject] {
        
        let red = (CIColor(color: color).red) * 255
        let green = (CIColor(color: color).green) * 255
        let blue = (CIColor(color: color).blue) * 255
        
        let dictionary:[String: AnyObject] = ["activate" : status,
                                              "r": red,
                                              "g": green,
                                              "b" : blue]
        
        return dictionary
    }
    
}

extension UIColor {
    
    func parse(dictionary:[String:String]) -> UIColor {
        var color:UIColor {
            return UIColor.init(red: CGFloat(Double(dictionary["red"]!)!), green: CGFloat(Double(dictionary["green"]!)!), blue: CGFloat(Double(dictionary["blue"]!)!), alpha: 1)
        }
        return color
    }
}

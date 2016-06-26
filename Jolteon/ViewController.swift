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
        
//        let dictionary = ["status": String(status)]

        if status { //light is on
        
//            JOLTEON_APIClient.post(dictionary) // post to turn off
            JOLTEON_APIClient.get({ (success, object) in
                
            })
            
            UIView.animateWithDuration(0.5, animations: {
                self.view.backgroundColor = UIColor.blackColor()
                self.view.layoutIfNeeded()
            })
            
            status = false
            panGestureRecognizer.enabled = false
            
        } else { // light is off
            
//            JOLTEON_APIClient.post(dictionary) // post to turn on
            JOLTEON_APIClient.get({ (success, object) in
//                if success {
//                    
//                    let color = UIColor()
//                        
//                        color.parse(object)
//                    
//                    
//                    self.view.backgroundColor = color
//                }
            })
            
            status = true
            UIView.animateWithDuration(0.5, animations: {
                self.view.backgroundColor = self.lastColor
                self.view.layoutIfNeeded()
            })
            panGestureRecognizer.enabled = true

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didPan(gestureRecognizer:UIPanGestureRecognizer) {
        
        print(angleForPoint(gestureRecognizer.locationInView(view)))
        view.backgroundColor = UIColor(hue: angleForPoint(gestureRecognizer.locationInView(view)), saturation: 1, brightness: 1, alpha: 1)
        
//        JOLTEON_APIClient.post(rgb(view.backgroundColor!))
        
    }
    
    func angleForPoint(point:CGPoint) -> CGFloat {
        var angle = CGFloat(-atan2f(Float(point.x - center.x), Float(point.y - center.y))) + CGFloat(M_PI)/2
        
        
        if (angle < 0) {
            angle += CGFloat(M_PI)*2;
        }
        
        angle = angle/CGFloat(M_PI)/2
        
        return angle
    }
    
    func rgb(color:UIColor) -> [String:String] {
        
        let dictionary = ["red": String(CIColor(color: color).red),
                          "green": String(CIColor(color: color).green),
                          "blue" : String(CIColor(color: color).blue)]
        
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

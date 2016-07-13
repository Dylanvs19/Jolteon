//
//  MainAppViewController.swift
//  Jolteon
//
//  Created by Dylan Straughan on 6/29/16.
//  Copyright © 2016 Dylan Straughan. All rights reserved.
//

import UIKit

class MainAppViewController: UIViewController {
    
    @IBOutlet var sideVCContainerView: UIView!
    @IBOutlet var mainVCContainerView: UIView!
    
    @IBOutlet var sideVCTrailingMargin: NSLayoutConstraint!
    @IBOutlet var mainVCCenterX: NSLayoutConstraint!
    
    var shouldPop = true
    
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ControlViewController") as? ControlViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(pop), name:"SideVCPop", object: nil)
        
    }
    
    
    func pop() {
        print("pop!")
        if shouldPop {
            shouldPop = false
            UIView.animateWithDuration(0.5, delay: 0, options: [], animations: {
                self.mainVCCenterX.constant = -self.view.frame.size.width * 0.3
                self.view.layoutIfNeeded()
                }, completion: nil)
            
        } else {
            shouldPop = true
            UIView.animateWithDuration(0.5, delay: 0, options: [.CurveEaseInOut], animations: {
                self.mainVCCenterX.constant = 0
                self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    
    
}

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
    
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ControlViewController") as? ControlViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(MainAppViewController.pop), name:"SideVCPop", object: nil)
        
        sideVCTrailingMargin.constant = -view.frame.size.width * 0.35
        
    }
    
    
    func pop() {
        print("pop!")
            sideVCTrailingMargin.constant = 0
            sideVCTrailingMargin.constant = -view.frame.size.width * 0.35

    }
    
    
    
}

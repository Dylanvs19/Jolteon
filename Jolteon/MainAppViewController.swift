//
//  MainAppViewController.swift
//  Jolteon
//
//  Created by Dylan Straughan on 6/29/16.
//  Copyright © 2016 Dylan Straughan. All rights reserved.
//

import UIKit

class MainAppViewController: UIViewController, ViewControllerDelegate {
    
    @IBOutlet var sideVCContainerView: UIView!
    @IBOutlet var mainVCContainerView: UIView!
    
    @IBOutlet var sideVCTrailingMargin: NSLayoutConstraint!
    @IBOutlet var mainVCCenterX: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideVCTrailingMargin.constant = -view.frame.size.width * 0.35
        
    }
    
    func shouldPop() {
        
        sideVCTrailingMargin.constant = 0
    }
    
    func shouldReturn() {
        
        sideVCTrailingMargin.constant = -view.frame.size.width * 0.35

    }
}

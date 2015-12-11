//
//  ViewController.swift
//  钟表运动swift
//
//  Created by 王志盼 on 15/12/9.
//  Copyright © 2015年 王志盼. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hourView: UIImageView!
    
    @IBOutlet weak var minuteView: UIImageView!
    
    @IBOutlet weak var secondView: UIImageView!
    
    var timer: NSTimer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hourView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        self.minuteView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        self.secondView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        
        self.updateWithAnimate(false)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("tick"), userInfo: nil, repeats: true)
        
    }
    
    func tick() {
        self.updateWithAnimate(true)
    }
    
    func updateWithAnimate(animate: Bool) {
        let calendar = NSCalendar()
    }

}


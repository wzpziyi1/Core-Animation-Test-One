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
    
    @IBOutlet weak var imageView: UIImageView!
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.insertSubview(imageView, atIndex: 0)
        self.hourView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        self.minuteView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        self.secondView.layer.anchorPoint = CGPointMake(0.5, 0.9)
        
        self.addTimer()
    }
    
    func addTimer() {
        self.updateWithAnimate(false)
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("tick"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer!, forMode: NSRunLoopCommonModes)
        
    }
    
    func removeTimer() {
        self.timer!.invalidate()
        self.timer = nil
    }
    
    func tick() {
        self.updateWithAnimate(true)
    }
    
    @objc func updateWithAnimate(animated: Bool) {
        let calendar = NSCalendar.currentCalendar()
        
        let unit: NSCalendarUnit = [NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second]
        let nowComponent = calendar.components(unit, fromDate: NSDate())
        
        let hourAngle = CGFloat(nowComponent.hour) / 12.0 * CGFloat(M_PI) * 2.0
        let minuteAngle = CGFloat(nowComponent.minute) / 60.0 * CGFloat(M_PI) * 2.0
        let secondAngle = CGFloat(nowComponent.second) / 60.0 * CGFloat(M_PI) * 2.0
        
//        print("\(hourAngle)   \(minuteAngle)   \(secondAngle)  \(M_PI)")
        
        self.setAngle(hourAngle, forView: hourView, animated: animated)
        self.setAngle(minuteAngle, forView: minuteView, animated: animated)
        self.setAngle(secondAngle, forView: secondView, animated: animated)
    }
    
    func setAngle(angle: CGFloat, forView view: UIView, animated: Bool) {
        var transform: CATransform3D = CATransform3DMakeRotation(angle, 0, 0, 1)
        if (animated) {
            let basicAnimate = CABasicAnimation(keyPath: "transform")
            basicAnimate.toValue = NSValue(CATransform3D: transform)
            
            self.updateWithAnimate(false)
            
            basicAnimate.duration = 0.5
            basicAnimate.delegate = self
            basicAnimate.fillMode = kCAFillModeForwards
//            basicAnimate.removedOnCompletion = false
            basicAnimate.setValue(view, forKeyPath: "view")
            view.layer.addAnimation(basicAnimate, forKey: nil)
        }
        else {
            view.layer.transform = transform
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        print("animationDidStop")
        let view = anim.valueForKeyPath("view") as! UIView
        let tempAnim = anim as? CABasicAnimation
        view.layer.transform = (tempAnim?.toValue?.CATransform3DValue)!
    }
    
    deinit {
        self.removeTimer()
    }
}


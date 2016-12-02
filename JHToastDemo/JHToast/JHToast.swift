
//
//  JHToast.swift
//  JHToast
//
//  Created by hanchen on 16/10/9.
//  Copyright © 2016年 LiJianhui. All rights reserved.
//

import UIKit

enum JHToastShowType {
    case JHToastShowTypeTop,
    JHToastShowTypeCenter,
    JHToastShowTypeBottom
}

let kDefaultForwardAnimationDuration:CFTimeInterval = 0.5
let kDefaultBackwardAnimationDuration:CFTimeInterval = 0.5
let kDefautlWaitAnimationDuration:CFTimeInterval = 1.0
let kDefaultTopMargin:CGFloat = 70
let kDefaultTextInset:CGFloat = 12

class JHToast: UILabel,CAAnimationDelegate {

    private var forwardAnimationDuration : CFTimeInterval!
    private var backwardAnimationDuration : CFTimeInterval!
    private var textInsets : UIEdgeInsets!
    private var maxWidth : CGFloat!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration
        self.textInsets = UIEdgeInsetsMake(kDefaultTextInset, kDefaultTextInset, kDefaultTextInset, kDefaultTextInset)
        self.maxWidth = UIScreen.main.bounds.size.width - 20
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.numberOfLines = 0
        self.textAlignment = .center
        self.textColor = UIColor.white
        self.font = UIFont.systemFont(ofSize: 13.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    func showToast(text:String, type:JHToastShowType) {
        
        self.text = text
        self.sizeToFit()
        self.showType(type: type)
    }
    
    private func showType(type:JHToastShowType) {
        let keyWindow = UIApplication.shared.delegate?.window
        self.addAnimationGroup()
        var point = keyWindow??.center
        switch type {
        case .JHToastShowTypeTop:
            point?.y = kDefaultTopMargin
            break
        case .JHToastShowTypeCenter:
            break
        case .JHToastShowTypeBottom:
            point?.y = (keyWindow??.bounds.size.height)! - kDefaultTopMargin
            break
        }
        self.center = point!
        keyWindow??.addSubview(self)
        
    }
    
    /**  Animation  */
    private func addAnimationGroup() {
        let forwardAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        forwardAnimation.duration = self.forwardAnimationDuration
        forwardAnimation.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.5, 1.7, 0.6, 0.85)
        forwardAnimation.fromValue = NSNumber.init(value: 0.0)
        forwardAnimation.toValue = NSNumber.init(value: 1.0)
        
        let backwardAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        backwardAnimation.duration = self.backwardAnimationDuration
        backwardAnimation.beginTime = forwardAnimation.duration + kDefautlWaitAnimationDuration
        backwardAnimation.timingFunction = CAMediaTimingFunction.init(controlPoints: 0.4, 0.15, 0.5, -0.7)
        backwardAnimation.fromValue = NSNumber.init(value: 1.0)
        backwardAnimation.toValue = NSNumber.init(value: 0.0)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [forwardAnimation,backwardAnimation]
        animationGroup.duration = forwardAnimation.duration + backwardAnimation.duration + kDefautlWaitAnimationDuration
        animationGroup.isRemovedOnCompletion = false
        animationGroup.delegate = self
        animationGroup.fillMode = kCAFillModeForwards
        
        self.layer.add(animationGroup, forKey: "customShow")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            self.removeFromSuperview()
            self.layer.removeAnimation(forKey: "customShow")
        }
    }
    
    /**  text  */
    override func sizeToFit() {
        super.sizeToFit()
        var frame = self.frame
        let width = self.bounds.size.width + self.textInsets.left + self.textInsets.right
        frame.size.width = min(width, self.maxWidth)
        frame.size.height = self.bounds.size.height + self.textInsets.top + self.textInsets.bottom
        self.frame = frame
        
    }
    override func draw(_ rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, self.textInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let size = self.text?.boundingRect(
            with: CGSize.init(width:  CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [NSFontAttributeName:self.font],
            context:nil).size
        let bound = CGRect.init(origin: bounds.origin, size: size!)
        return bound
    }
    
    
    
    
    
    
    
    
    

}

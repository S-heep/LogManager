//
//  TouchButton.swift
//  LogManager
//
//  Created by 王娜 on 2018/2/6.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit

class TouchButton: UIButton {

    var moveEnable: Bool = false
    var moveEnabled: Bool = false
    var beginPoint: CGPoint = CGPoint(x: 0, y: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveEnabled = false
        super.touchesBegan(touches, with: event)
        if !moveEnable {
            return
        }
        let touch = touches.first
        beginPoint = (touch?.location(in: self))!
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        moveEnabled = true
        if !moveEnable {
            return
        }
        let touch = touches.first
        let currentPosition = touch?.location(in: self)
        let offSetX = (currentPosition?.x)! - beginPoint.x
        let offSetY = (currentPosition?.y)! - beginPoint.y
        self.center = CGPoint(x: self.center.x + offSetX, y: self.center.y + offSetY)
        // 左右边界定界
        if self.center.x > ((self.superview?.frame.size.width)! - self.frame.size.width / 2) {
            let x = (self.superview?.frame.size.width)! - self.frame.size.width / 2
            self.center = CGPoint(x: x, y: self.center.y + offSetY)
        } else if self.center.x < self.frame.size.width / 2 {
            let x = self.frame.size.width / 2
            self.center = CGPoint(x: x, y: self.center.y + offSetY)
        }
        // 上下边界定界
        if self.center.y > (self.superview?.frame.size.height)! - self.frame.size.height / 2 {
            let x = self.center.x
            let y = (self.superview?.frame.size.height)! - self.frame.size.height / 2
            self.center = CGPoint(x: x, y: y)
        } else if self.center.y <= self.frame.size.height / 2 {
            let x = self.center.x
            let y = self.frame.size.height / 2
            self.center = CGPoint(x: x, y: y)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !moveEnable {
            return
        }
        if self.center.x >= (self.superview?.frame.size.width)! / 2 {
            UIView.beginAnimations("move", context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationDelegate(self)
            self.frame = CGRect(x: (self.superview?.frame.size.width)! - 40, y: self.center.y - 20, width: 40, height: 40)
            UIView.commitAnimations()
        } else {
            UIView.beginAnimations("move", context: nil)
            UIView.setAnimationDuration(0.5)
            UIView.setAnimationDelegate(self)
            self.frame = CGRect(x: 0, y: self.center.y - 20, width: 40, height: 40)
            UIView.commitAnimations()
        }
        super.touchesEnded(touches, with: event)
    }
}

//
//  HomePageVC.swift
//  LasVegas
//
//  Created by 王娜 on 2018/1/4.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit

class LoggerShowManagerVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.init(red: 181.0/255, green: 104.0/255, blue: 48.0/255, alpha: 1)

        addChildViewController(childController: ShowLoggerViewController(), title: "日志", imageName: "toolBar_1")
        addChildViewController(childController: AdjustSignalViewController(), title: "信号强度调节", imageName: "toolBar_2")
        addChildViewController(childController: GoBackViewController(), title: "返回App", imageName: "toolBar_3")
        self.view.backgroundColor = UIColor.white
    }

    private func addChildViewController(childController: UIViewController, title:String, imageName:String) {

        childController.tabBarItem.image = UIImage(named: "\(imageName)_off")?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(red: 181.0/255, green: 104.0/255, blue: 48.0/255, alpha: 1)], for: .selected)
        childController.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.init(red: 85.0/255, green: 85.0/255, blue: 85.0/255, alpha: 1)], for: .normal)
        // 文字向上移动3个像素，减少图片与字体的间距差。
        childController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        childController.tabBarItem.title = title
        childController.navigationItem.title = title
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (item.title?.elementsEqual("返回App"))! {
            UIApplication.shared.keyWindow?.rootViewController = ViewController()
        }
    }
}


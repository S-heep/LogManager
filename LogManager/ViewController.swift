//
//  ViewController.swift
//  LogManager
//
//  Created by 王娜 on 2018/1/25.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        setenv("XcodeColors", "YES", 0)
        DDLog.add(DDTTYLogger.sharedInstance)
        // 启用颜色区分
        DDTTYLogger.sharedInstance.colorsEnabled = true
        // 设置文字为白色，背景为灰色
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.white, backgroundColor: UIColor.gray, for: DDLogFlag.verbose)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.red, backgroundColor: UIColor.white, for: DDLogFlag.debug)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.cyan, backgroundColor: UIColor.blue, for: DDLogFlag.info)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.lightGray, backgroundColor: UIColor.orange, for: DDLogFlag.warning)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.white, backgroundColor: UIColor.red, for: DDLogFlag.error)
        DDLog.add(fileLogger)
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
        DDLogError("Error")
        print("This is a Log Manager")


    }

}


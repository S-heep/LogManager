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
        LoggerManager.shared().configLoggerManager()
        ExceptionManager.init().setDefaultHandler()
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
        DDLogError("Error")
        print("This is a Log Manager")
        let array = [String]()
        //DDLogError(array[1])
    }

}


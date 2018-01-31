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
        
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
//        fatalError("我是错误，我会奔溃")
        DDLogError("Error")
        print("This is a Log Manager")
        signal(SIGTRAP) { (excep) in
            print("------")
            print(excep.description)
        }

        registerUncaughtExceptionHandler()
        let array = [String]()
        DDLogVerbose(array[1])
//        assert(false, "我是提醒，我不会奔溃")
//        fatalError("我是错误，我会奔溃")
//        assert(true)

        //print(array[1])

    }



}


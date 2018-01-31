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
        ExceptionManager.shared().setDefaultHandler()
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
//        fatalError("我是错误，我会奔溃")
        DDLogError("Error")
        print("This is a Log Manager")

        //exceptionLogWithData()
        let arry:NSArray = ["1"]
        print("%@",arry[5])
        //print(array[2])
//        assert(false, "我是提醒，我不会奔溃")
//        fatalError("我是错误，我会奔溃")
//        assert(true)

        //print(array[1])

    }

    func exceptionLogWithData() {
        ExceptionManager.shared().setDefaultHandler()
        //        let a = ExceptionManager.init()
        //        a.setDefaultHandler()
        //        let str = a.getdataPath()
        //        let data = NSData.init(contentsOfFile: str)
        //        if data != nil {
        //            let crushStr = String.init(data: data as! Data, encoding: String.Encoding.utf8)
        //            print(crushStr!)
        //        }
        //测试数据
        let arry:NSArray = ["1"]
        print("%@",arry[5])
    }


}


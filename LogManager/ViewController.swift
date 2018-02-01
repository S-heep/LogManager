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
    var bteste: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        LoggerManager.shared().configLoggerManager()
        ExceptionManager.shared().setDefaultHandler()
        ExceptionManager.shared().registerSignalHandler()
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
        DDLogError("Error")
        print("This is a Log Manager")

        print(bteste!)

        //exceptionLogWithData()
//        let arry:NSArray = ["1"]
//        print("%@",arry[5])
        //print(array[2])

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
//        let atest = nil
//        print(atest!)
        let arry:NSArray = ["1"]
        print("%@",arry[5])
    }


}


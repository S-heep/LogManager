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
        signalExcep()
    }

    func signalExcep() {
        let button = UIButton.init(frame: CGRect(x: 100, y: 200, width: 200, height: 44))
        button.setTitle("signal exception", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(execee), for: .touchUpInside)

        let button1 = UIButton.init(frame: CGRect(x: 100, y: 300, width: 200, height: 44))
        button1.setTitle("normal exception", for: .normal)
        button1.backgroundColor = UIColor.blue
        button1.setTitleColor(.red, for: .normal)
        button1.addTarget(self, action: #selector(exceptionLogWithData), for: .touchUpInside)

        view.addSubview(button)
        view.addSubview(button1)
    }

    @objc func execee() {
        bteste = bteste! + "sss"
    }

    @objc func exceptionLogWithData() {
        let arry:NSArray = ["1"]
        print("%@",arry[5])
    }


}


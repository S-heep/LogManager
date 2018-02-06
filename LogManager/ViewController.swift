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

        let button2 = UIButton.init(frame: CGRect(x: 100, y: 400, width: 200, height: 44))
        button2.setTitle("logSystem", for: .normal)
        button2.backgroundColor = UIColor.blue
        button2.setTitleColor(.red, for: .normal)
        button2.addTarget(self, action: #selector(logSys), for: .touchUpInside)

        view.addSubview(button)
        view.addSubview(button1)
        //view.addSubview(button2)
        // 设置一个蒙版效果
        let aView = UIView.init(frame: view.frame)
        aView.backgroundColor = UIColor.lightGray
        aView.alpha = 0.7
        view.addSubview(aView)
        aView.addSubview(button2)
    }

    @objc func execee() {
        bteste = bteste! + "sss"
    }

    @objc func exceptionLogWithData() {
        let arry:NSArray = ["1"]
        print("%@",arry[5])
    }

    @objc func logSys() {
        self.navigationController?.pushViewController(ShowLoggerViewController(), animated: true)
    }

}


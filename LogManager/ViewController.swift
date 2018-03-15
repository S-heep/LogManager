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
    var flag: Bool = false
    var myButton: TouchButton!
    var aWindow: UIWindow!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        LoggerManager.shared().configLoggerManager()
        ExceptionManager.shared().setDefaultHandler()
        ExceptionManager.shared().registerSignalHandler()
        DDLogVerbose("Verbose")
        DDLogDebug("Debug")
        DDLogInfo("Info")
        DDLogWarn("Warn")
        DDLogError("Error")
        print("This is a Log Manager")
        print("This is a Log Manager test to catch a github")
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

        myButton = TouchButton.init(frame: CGRect(x: 0, y: 100, width: 40, height: 40))
        myButton.moveEnable = true
        myButton.tag = 10
        flag = false
        myButton.setTitle("log", for: .normal)
        myButton.layer.borderColor = UIColor.black.cgColor
        myButton.layer.borderWidth = 0.5
        myButton.layer.cornerRadius = 20
        myButton.backgroundColor = UIColor.cyan
        //myButton.setBackgroundImage(UIImage.init(named: "touch"), for: .normal)
        myButton.addTarget(self, action: #selector(touchBar), for: .touchUpInside)
        view.addSubview(button)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(myButton)
        
    }

    @objc func touchBar() {
        if !myButton.moveEnabled {
            if !flag {
                self.navigationController?.pushViewController(LoggerShowManagerVC(), animated: true)
                //UIApplication.shared.keyWindow?.rootViewController = LoggerShowManagerVC()
            }
        }
    }

    @objc func execee() {
        bteste = bteste! + "sss"
    }

    @objc func exceptionLogWithData() {
        let arry:NSArray = ["1"]
        print("%@",arry[5])
    }

    @objc func logSys() {
        //UIApplication.shared.keyWindow?.rootViewController = LoggerShowManagerVC()
        self.navigationController?.pushViewController(AtestViewController(), animated: true)
    }

}


//
//  DetailLoggerViewController.swift
//  LogManager
//
//  Created by 王娜 on 2018/2/5.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit

class DetailLoggerViewController: UIViewController {

    var logContent: String!
    var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initTextView()
    }

    func initLogContent(logString: String) {
        logContent = logString
    }

    func initTextView() {
        textView = UITextView.init(frame: view.frame)
        textView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.RawValue(UInt8(UIViewAutoresizing.flexibleHeight.rawValue) | UInt8(UIViewAutoresizing.flexibleWidth.rawValue)))
        textView.isEditable = false
        textView.text = logContent
        view.addSubview(textView)
    }


}

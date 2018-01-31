//
//  ExceptionManager.swift
//  LogManager
//
//  Created by 王娜 on 2018/1/30.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ExceptionManager: NSObject {

    func uncaughtExceptionHandler(excep: NSException) {
        let array: [String] = excep.callStackSymbols
        let reason: String? = excep.reason
        let name: NSExceptionName = excep.name
        let url: String = String.init(format: "****异常错误****\n name: %@ \n reason: %@\n callStackSymbols: %@\n", name as CVarArg, (reason)!, array.joined(separator: ","))
        DDLogError(url)
    }

    func uncaughtExceptionHandler() -> @convention(c) (NSException) -> Void {
        return { (excep) -> Void in
            let array: [String] = excep.callStackSymbols
            let reason: String? = excep.reason
            let name: NSExceptionName = excep.name
            let url: String = String.init(format: "****异常错误****\n name: %@ \n reason: %@\n callStackSymbols: %@\n", name as CVarArg, reason!, array.joined(separator: ","))
            DDLogError(url)
        }
    }


    func getHandler() -> NSUncaughtExceptionHandler {
        return NSGetUncaughtExceptionHandler()!
    }

    func setDefaultHandler() {
        // 传一个闭包
        DDLogDebug("进入设置默认异常情况")
        NSSetUncaughtExceptionHandler { (excep) in
            DDLogError(excep.callStackSymbols.joined())
        }
    }

    func takeException(excep: NSException) {
        let array: [String] = excep.callStackSymbols
        let reason: String? = excep.reason
        let name: NSExceptionName = excep.name
        let url: String = String.init(format: "****异常错误****\n name: %@ \n reason: %@\n callStackSymbols: %@\n", name as CVarArg, reason!, array.joined(separator: ","))
        DDLogError(url)
    }

}

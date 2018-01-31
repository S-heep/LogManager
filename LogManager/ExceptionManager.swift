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

    private static let sharedExceManager: ExceptionManager = {
        let sharedInstance = ExceptionManager()
        return sharedInstance
    }()

    class func shared() -> ExceptionManager {
        return sharedExceManager
    }

    public func getdataPath() -> String{
        let str = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let urlPath = str.appending("Exception.txt")
        print("文件路径:\(urlPath)")
        return urlPath
    }

    public func setDefaultHandler() {
        LoggerManager.shared().configLoggerManager()
        NSSetUncaughtExceptionHandler { (exception) in
            let arr:NSArray = exception.callStackSymbols as NSArray
            let reason:String = exception.reason!
            let name:String = exception.name.rawValue
            let date:NSDate = NSDate()
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "YYYY/MM/dd hh:mm:ss SS"
            let strNowTime = timeFormatter.string(from: date as Date) as String
            let url:String = String.init(format: "========异常错误报告========\ntime:%@\nname:%@\nreason:\n%@\ncallStackSymbols:\n%@",strNowTime,name,reason,arr.componentsJoined(by: "\n"))
            DDLogVerbose("以下时奔溃日志")
            DDLogError(url)
            let documentpath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
            let path = documentpath.appending("Exception.txt")
            do{
                try
                    url.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            }catch{}
        }
    }

//    func uncaughtExceptionHandler(excep: NSException) {
//        let array: [String] = excep.callStackSymbols
//        let reason: String? = excep.reason
//        let name: NSExceptionName = excep.name
//        let url: String = String.init(format: "****异常错误****\n name: %@ \n reason: %@\n callStackSymbols: %@\n", name as CVarArg, (reason)!, array.joined(separator: ","))
//        DDLogError(url)
//    }
//
//    func uncaughtExceptionHandler() -> @convention(c) (NSException) -> Void {
//        return { (excep) -> Void in
//            let array: [String] = excep.callStackSymbols
//            let reason: String? = excep.reason
//            let name: NSExceptionName = excep.name
//            let url: String = String.init(format: "****异常错误****\n name: %@ \n reason: %@\n callStackSymbols: %@\n", name as CVarArg, reason!, array.joined(separator: ","))
//            DDLogError(url)
//        }
//    }
//
//
//    func getHandler() -> NSUncaughtExceptionHandler {
//        return NSGetUncaughtExceptionHandler()!
//    }
//
//    func setDefaultHandler() {
//        // 传一个闭包
//        DDLogDebug("进入设置默认异常情况")
//        NSSetUncaughtExceptionHandler { (excep) in
//            DDLogError(excep.callStackSymbols.joined())
//        }
//    }


}

//
//  ExceptionManager.swift
//  LogManager
//
//  Created by 王娜 on 2018/1/30.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit
import CocoaLumberjack

func signalExceptionHandler(signal: Int32) {

    var mstr = String()
    mstr += "Stack:\n"
    //增加偏移量地址
    mstr = mstr.appendingFormat("slideAdress:0x%0x\r\n", calculate())
    //增加错误信息
    for symbol in Thread.callStackSymbols {
        mstr = mstr.appendingFormat("%@\r\n", symbol)
    }
    //        CrashManager.saveCrash(appendPathStr: .signalCrashPath, exceptionInfo: mstr)
    //        exit(signal)
}

class ExceptionManager: NSObject {

    // 设置类是单例
    private static let sharedExceManager: ExceptionManager = {
        let sharedInstance = ExceptionManager()
        return sharedInstance
    }()

    class func shared() -> ExceptionManager {
        return sharedExceManager
    }

    // 设置奔溃信息保存文件名与保存路径
    public func getdataPath() -> String{
        let str = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        let urlPath = str.appending("Exception.txt")
        print("文件路径:\(urlPath)")
        return urlPath
    }

    // 设置奔溃信息格式
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

    // 设置 1.具有nil值的非可选类型 2.一个失败的强制类型转换 的奔溃信息


    //MARK: - 注册信号
    func registerSignalHandler() {

        //    如果在运行时遇到意外情况，Swift代码将以SIGTRAP此异常类型终止，例如：
        //    1.具有nil值的非可选类型
        //    2.一个失败的强制类型转换
        //    查看Backtraces以确定遇到意外情况的位置。附加信息也可能已被记录到设备的控制台。您应该修改崩溃位置的代码，以正常处理运行时故障。例如，使用可选绑定而不是强制解开可选的。

        print("我是注册函数")
        signal(SIGABRT) { (SIGABRT) in
            signalExceptionHandler(signal: SIGABRT)
        }

        signal(SIGSEGV) { (SIGSEGV) in
            signalExceptionHandler(signal: SIGSEGV)
        }

        signal(SIGBUS) { (SIGBUS) in
            signalExceptionHandler(signal: SIGBUS)
        }

        signal(SIGTRAP) { (SIGTRAP) in
            signalExceptionHandler(signal: SIGTRAP)
        }

        signal(SIGILL) { (SIGILL) in
            signalExceptionHandler(signal: SIGILL)
        }
//        signal(SIGABRT, signalExceptionHandler)
//        signal(SIGSEGV, signalExceptionHandler)
//        signal(SIGBUS, signalExceptionHandler)
//        signal(SIGTRAP, signalExceptionHandler)
//        signal(SIGILL, signalExceptionHandler)

        //如果需要搜集其他信号崩溃则按需打开如下代码
        //    signal(SIGHUP, SignalExceptionHandler)
        //    signal(SIGINT, SignalExceptionHandler)
        //    signal(SIGQUIT, SignalExceptionHandler)
        //    signal(SIGFPE, SignalExceptionHandler)
        //    signal(SIGPIPE, SignalExceptionHandler)

        /*
         //闭包形式
         signal(SIGABRT) { (sig) in
         SignalExceptionHandler(signal: sig)
         }
         signal(SIGSEGV) { (sig) in
         SignalExceptionHandler(signal: sig)
         }
         signal(SIGBUS) { (sig) in
         SignalExceptionHandler(signal: sig)
         }
         signal(SIGTRAP) { (sig) in
         SignalExceptionHandler(signal: sig)
         }
         signal(SIGILL) { (sig) in
         SignalExceptionHandler(signal: sig)
         }
         */

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

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
    var messageInfo = String.init()
    mstr += "Stack:\n"
    //增加偏移量地址
    mstr = mstr.appendingFormat("slideAdress:0x%0x\r\n", calculate())
    //增加错误信息
    for symbol in Thread.callStackSymbols {
        mstr = mstr.appendingFormat("%@\r\n", symbol)
    }
//    let array: [String] = excep.callStackSymbols
//    let reason: String = excep.reason!
//    let name: String = excep.name.rawValue
    let tips: String = "该类异常常见于2类错误，1.具有nil值的非可选类型 2.一个失败的强制类型转换"
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    let time: String = dateFormatter.string(from: Date())
    messageInfo += "\n========Crash异常错误报告========\ntime: \(time)\ntips: \(tips)\n \(mstr)"
    let filePath = getdataPath()
    let fileHandler = FileHandle.init(forWritingAtPath: filePath)
    fileHandler?.seekToEndOfFile()
    let crashData = messageInfo.data(using: String.Encoding.utf8)
    fileHandler?.write(crashData!)
    DDLogVerbose("\n以下是奔溃日志\n")
    DDLogError(mstr)
}

// 设置统一的奔溃日志输出文件,设置奔溃信息保存文件名与保存路径
func getdataPath() -> String {
    let fileManager = FileManager.default
    let filePath: String = NSHomeDirectory() + "/Documents/CrashInfo.txt"
    let exist = fileManager.fileExists(atPath: filePath)
    if !exist {
        fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
    }
    print("文件路径:\(filePath)")
    return filePath
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

    // 设置奔溃信息格式
    public func setDefaultHandler() {
        LoggerManager.shared().configLoggerManager()
        NSSetUncaughtExceptionHandler { (excep) in
            // 提取奔溃日志信息，设置日志格式
            let array: [String] = excep.callStackSymbols
            let reason: String = excep.reason!
            let name: String = excep.name.rawValue
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    
            let time: String = dateFormatter.string(from: Date())
            let crashMes: String = String.init(format: "\n========Crash异常错误报告========\ntime: %@\nname: %@\n reason: %@\ncallStackSymbols: %@\n",time,name,reason,array.joined(separator: "\n"))
            let filePath = getdataPath()
            let fileHandler = FileHandle.init(forWritingAtPath: filePath)
            fileHandler?.seekToEndOfFile()
            let crashData = crashMes.data(using: String.Encoding.utf8)
            fileHandler?.write(crashData!)
            DDLogVerbose("\n以下是奔溃日志\n")
            DDLogError(crashMes)
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
//        signal(SIGABRT) { (SIGABRT) in
//            signalExceptionHandler(signal: SIGABRT)
//        }
//
//        signal(SIGSEGV) { (SIGSEGV) in
//            signalExceptionHandler(signal: SIGSEGV)
//        }
//
//        signal(SIGBUS) { (SIGBUS) in
//            signalExceptionHandler(signal: SIGBUS)
//        }

        signal(SIGTRAP) { (aSignal) in
            DDLogError("\nSIGTRAP捕获的奔溃信息\n")
            signalExceptionHandler(signal: aSignal)
            signal(SIGTRAP, SIG_DFL)
        }

        //signal(SIGILL) { (SIGILL) in
        //     signalExceptionHandler(signal: SIGILL)
        //}
        // signal(SIGABRT, signalExceptionHandler)
        // signal(SIGSEGV, signalExceptionHandler)
        // signal(SIGBUS, signalExceptionHandler)
        // signal(SIGTRAP, signalExceptionHandler)
        // signal(SIGILL, signalExceptionHandler)

        //如果需要搜集其他信号崩溃则按需打开如下代码
        //    signal(SIGHUP, SignalExceptionHandler)
        //    signal(SIGINT, SignalExceptionHandler)
        //    signal(SIGQUIT, SignalExceptionHandler)
        //    signal(SIGFPE, SignalExceptionHandler)
        //    signal(SIGPIPE, SignalExceptionHandler)

    }

    func unRegisterSignalHandler()
    {
        // signal(SIGINT, SIG_DFL);
        // signal(SIGSEGV, SIG_DFL);
        signal(SIGTRAP, SIG_DFL)
        // signal(SIGABRT, SIG_DFL);
        // signal(SIGILL, SIG_DFL);
    }

}

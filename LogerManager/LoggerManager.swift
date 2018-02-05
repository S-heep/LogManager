//
//  MyLogManager.swift
//  LogManager
//
//  Created by 王娜 on 2018/1/29.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit
import CocoaLumberjack


/*  此类是日志管理单例类，配置三类日志管理器：1.DDTTYLogger：控制台输出 2.DDASLLogger：苹果系统日志 3.DDFileLogger：文件日志
    不同级别日志的显示背景颜色与文字颜色，暂未实现（优先级不高,使用XcodeColors实现，但是Xcode9以后该插件不再起作用）
*/
class LoggerManager: NSObject {

    var fileLogger: DDFileLogger!
    private static let sharedLogManager: LoggerManager = {
        let shared = LoggerManager()
        return shared
    }()

    class func shared() -> LoggerManager {
        return sharedLogManager
    }

    func configLoggerManager() {
        let formatter = LoggerFormatter.init()
        DDTTYLogger.sharedInstance.logFormatter = formatter
        DDASLLogger.sharedInstance.logFormatter = formatter
        // 一个文件记录一周的日志
        fileLogger = DDFileLogger()
        fileLogger.rollingFrequency = TimeInterval(60*60*24)
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        // 设置输入日志文件的日志格式
        fileLogger.logFormatter = formatter
        DDLog.add(fileLogger)
        // TTY = Xcode console，Xcode控制台
        DDLog.add(DDTTYLogger.sharedInstance)
        // ASL = Apple System Logs，苹果系统日志
        DDLog.add(DDASLLogger.sharedInstance)

        //获取log文件夹路径
        let logDirectory = fileLogger.logFileManager.logsDirectory
        DDLogDebug(logDirectory!)
        //获取排序后的log名称
        //let logsNameArray = fileLogger.logFileManager.sortedLogFileNames
        //DDLogDebug("%@", level: logsNameArray)
        // 背景颜色设置需要查看XcodeColors，优先级不高
        setenv("XcodeColors", "YES", 0)
        DDLog.add(DDTTYLogger.sharedInstance)
        DDTTYLogger.sharedInstance.colorsEnabled = true
        // 启用颜色区分
        DDTTYLogger.sharedInstance.colorsEnabled = true
        // 设置文字为白色，背景为灰色
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.white, backgroundColor: UIColor.gray, for: DDLogFlag.verbose)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.red, backgroundColor: UIColor.white, for: DDLogFlag.debug)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.cyan, backgroundColor: UIColor.blue, for: DDLogFlag.info)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.lightGray, backgroundColor: UIColor.orange, for: DDLogFlag.warning)
        DDTTYLogger.sharedInstance.setForegroundColor(UIColor.white, backgroundColor: UIColor.red, for: DDLogFlag.error)
    }
}

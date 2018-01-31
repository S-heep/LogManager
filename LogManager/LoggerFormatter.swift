//
//  LoggerFormatter.swift
//  LogManager
//
//  Created by 王娜 on 2018/1/29.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit
import CocoaLumberjack

/// 该类设置不同级别日志输出的前缀，重写日志输出格式，日志显示顺序是【日志级别】- 时间 - 文件名称 - 行号 - 函数名 - 日志信息
class LoggerFormatter: NSObject, DDLogFormatter {

    func format(message logMessage: DDLogMessage) -> String? {
        var logLevel = ""
        switch logMessage.flag {
        case DDLogFlag.error:
            logLevel = "[ERROR]"
        case DDLogFlag.warning:
            logLevel = "[WARNING]"
        case DDLogFlag.info:
            logLevel = "[INFO]"
        case DDLogFlag.debug:
            logLevel = "[DEBUG]"
        default:
            logLevel = "[VERBOSE]"
        }
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let formatStr = String.init(format: "%@ %@ [%@][line %ld] %@ %@", logLevel, dateFormatter.string(from: logMessage.timestamp), logMessage.fileName, logMessage.line, logMessage.function!, logMessage.message)
        return formatStr
    }
}

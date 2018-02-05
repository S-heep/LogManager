//
//  ShowLoggerViewController.swift
//  LogManager
//
//  Created by 王娜 on 2018/2/5.
//  Copyright © 2018年 王娜. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ShowLoggerViewController: UIViewController {

    var tableView: UITableView!
    // 所有日志
    var ddLogerFiles = [DDLogFileInfo]()
    // 奔溃日志
    var crashLoggerFile = ExceptionManager.shared().logFilePath
    // 初始化日期格式
    var dateFormat: DateFormatter!

    override func viewDidLoad() {
        super.viewDidLoad()
        initDateFormate()
        initTableView()
        loadLoggerFiles()
    }

    func initDateFormate() {
        dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "YYYY-MM-dd HH:mm:ss"
    }

    func initTableView() {
        tableView = UITableView.init(frame: view.frame, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = initLable()
        view.addSubview(tableView)
    }

    func loadLoggerFiles() {
        ddLogerFiles = LoggerManager.shared().fileLogger.logFileManager.sortedLogFileInfos
    }

    func initLable() -> UIView {
        let aView = UIView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
        let label = UILabel.init(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 10))
        label.text = "日志列表"
        label.textAlignment = NSTextAlignment.center
        aView.addSubview(label)
        return aView
    }
}

extension ShowLoggerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
        // 可以返回3个section，其中的一个进行旧文件的清理工作
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return ddLogerFiles.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.section == 1 {
            let logFile = ddLogerFiles[indexPath.row]
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            cell?.textLabel?.text = dateFormat.string(from: logFile.creationDate)
        } else {
            cell?.textLabel?.text = "所有奔溃日志"
        }
        return cell!

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "奔溃日志"
        } else {
            return "所有日志"
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 加载日志
        if indexPath.section == 0 {
            do {
                let crashInfo = try String.init(contentsOfFile: crashLoggerFile, encoding: String.Encoding.utf8)
                let vc = DetailLoggerViewController()
                vc.initLogContent(logString: crashInfo)
                self.navigationController?.pushViewController(vc, animated: true)

            } catch {
                print("未获取到奔溃日志")
            }

        }
        if indexPath.section == 1 {
            let logFile = ddLogerFiles[indexPath.row]
            do {
                let logData = try String.init(contentsOfFile: logFile.filePath, encoding: String.Encoding.utf8)
                let vc = DetailLoggerViewController()
                vc.initLogContent(logString: logData)
                self.navigationController?.pushViewController(vc, animated: true)

            } catch {
                print("未获取到log日志")
            }
        }
    }
}

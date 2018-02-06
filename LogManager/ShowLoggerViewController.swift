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
        self.initDateFormate()
        self.initTableView()
        self.loadLoggerFiles()
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
        return 3
        // 可以返回3个section，其中的一个进行旧文件的清理工作
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0

        switch section {
        case 0:
            row = 1
        case 1:
            row = ddLogerFiles.count
        case 2:
            row = 1
        default:
            print("error Happened")
        }
        return row
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellID")
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        if indexPath.section == 0 {
            cell?.textLabel?.text = "所有奔溃日志"
        }
        if indexPath.section == 1 {
            let logFile = ddLogerFiles[indexPath.row]
            cell?.textLabel?.text = dateFormat.string(from: logFile.creationDate)
        }
        if indexPath.section == 2 {
            cell?.textLabel?.text = "清理缓存日志"
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell!

    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "奔溃日志"
        } else if section == 1{
            return "所有日志"
        } else {
            return "日志清理"
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
        if indexPath.section == 2 {
            let attributedStr = NSMutableAttributedString.init(string: "点击确定以后会删除所有缓存日志，只保留当日日志，是否确定要删除")
            attributedStr.addAttribute(kCTForegroundColorAttributeName as NSAttributedStringKey,
                                       value: UIColor.init(red: 42.0/255, green: 42.0/255, blue: 42.0/255, alpha: 1),
                                       range: NSRange(location: 0, length: 31))
            attributedStr.addAttribute(kCTFontAttributeName as NSAttributedStringKey, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 0, length: 31))
            let actionSheet = UIAlertController.init(title: "点击确定以后会删除所有缓存日志，只保留当日日志，是否确定要删除", message: nil, preferredStyle: .alert)
            actionSheet.setValue(attributedStr, forKey: "attributedTitle")
            let action = UIAlertAction.init(title: "取消", style: .default, handler: nil)
            let action1 = UIAlertAction.init(title: "确定", style: .default, handler: { (_) in
                // 执行删除日志操作
                for file in self.ddLogerFiles {
                    if file.isArchived {
                        do {
                            try FileManager.default.removeItem(atPath: file.filePath)
                        } catch {
                            print("未能删除缓存文件")
                        }
                    }
                }
                self.loadLoggerFiles()
                tableView.reloadData()
            })

            action.setValue(UIColor.init(red: 42.0/255, green: 42.0/255, blue: 42.0/255, alpha: 0.9),
                            forKey: "titleTextColor")
            action1.setValue(UIColor.blue,
                             forKey: "titleTextColor")
            actionSheet.addAction(action)
            actionSheet.addAction(action1)
            self.navigationController?.present(actionSheet, animated: true, completion: nil)
        }
    }
}

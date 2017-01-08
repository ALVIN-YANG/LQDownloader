//
//  LQDownload.swift
//  LQDownload
//
//  Created by 杨卢青 on 2017/1/6.
//  Copyright © 2017年 杨卢青. All rights reserved.
//

import UIKit

enum LQDownloadState {
	case begin
	case pause
	case complete
	case failed
}

struct LQSessionModel {
	var stream: OutputStream
	var url: String
	var totalLength: Int
	var progressBlock: (Int, Int, Double) -> Void
	var stateBlock: (LQDownloadState) -> Void
}

class LQDownload: NSObject {
	
	//下载路径: 重新下载或者重新生成的数据放在Library/Caches里面
	func downloadDirectory() -> String {
		
		return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last!.appending("/TTCache")
	}
	
	//文件名
	func fileName(_ url: String) -> String? {
		return url.components(separatedBy: "/").last
	}
	
	//文件全路径
	func fileFullPath(_ url: String) -> String {
		return downloadDirectory() + "\(fileFullPath(url))"
	}
	
	//文件已下载大小
	func fileDownloadSize(_ url: String) -> Int? {
		var filesize: Int?
		do {
			let attr = try FileManager.default.attributesOfItem(atPath: fileFullPath(url))
			filesize = attr[FileAttributeKey.size] as? Int
		} catch {
			debugPrint("Error: \(error)")
		}
		return filesize
	}
	
	//存储文件总长度.plist的文件路径
	func totalLengthFullPath() -> String{
		return downloadDirectory().appending("/totalLength.plist")
	}
	
	var tasks = Dictionary<String, URLSessionTask>()
	var sessionModels = Dictionary<Int, LQSessionModel>()
	
	//单例
	private static let instance = LQDownload()
	class func shared() -> LQDownload {
		return instance
	}
	
	//创建下载目录文件
	func createDownloadDirectory() {
		if !FileManager.default.fileExists(atPath: downloadDirectory()) {
			do{ try FileManager.default.createDirectory(atPath: downloadDirectory(), withIntermediateDirectories: true, attributes: nil)
			} catch {
				debugPrint("Error: \(error)")
			}
		}
	}
	
	//开启任务, 下载资源
	func download(_ url: String, progress: (_ cur: Int, _ end: Int, _ progress: CGFloat) -> Void, state: (LQDownloadState) -> Void) {
		if isComplate(url) {
			state(.complete)
			debugPrint("(￣.￣)该资源已下载完成")
			return
		}
		//任务已存在 执行 继续或暂停
		guard let fileName = fileName(url) else { return }
		if let _ = tasks[fileName] {
			handle(url)
			return
		}
		
		//创建任务
		createDownloadDirectory()
		
		let config = URLSessionConfiguration.default
		let session = URLSession.init(configuration: config)
		
		
	}
	
	//判断该资源是否下载完成
	func isComplate(_ url: String) -> Bool {
		guard let size = fileTotalSize(url) else { return false }
		if size == fileDownloadSize(url) {
			return true
		}
		return false
	}
	
	//获取对应资源的大小: 大小存储在totalLength.plist, key为url
	func fileTotalSize(_ url: String) -> Int? {
		if let data = try? Data(contentsOf: URL(fileURLWithPath: totalLengthFullPath())){
			if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
				let fileName = fileName(url) {
				return result?[fileName] as? Int
			}
		}
		return nil
	}
	
//	case running
//	case suspended
//	case canceling
//	case completed
	//开始或暂停
	func handle(_ url: String) {
		guard let task = getTask(url) else { return }
		switch task.state {
		case .running:
			pause(url)
		default:
			start(url)
		}
	}
	
	//根据url获取对应任务
	func getTask(_ url: String) -> URLSessionTask? {
		guard let fileName = fileName(url) else { return nil }
		guard let task = tasks[fileName] else { return nil }
		return task as URLSessionTask
	}
	
	//根据task.Identifier获取下载信息模型
	func getSessionModel(_ taskIdentifier: Int) -> LQSessionModel? {
		return sessionModels[taskIdentifier]
	}
	
	//暂停下载
	func pause(_ url: String) {
		guard let task = getTask(url) else { return }
		task.suspend()
		getSessionModel(task.taskIdentifier)?.stateBlock(.pause)
	}
	
	//开始下载
	func start(_ url: String) {
		guard let task = getTask(url) else { return }
		task.resume()
		getSessionModel(task.taskIdentifier)?.stateBlock(.begin)
	}
}

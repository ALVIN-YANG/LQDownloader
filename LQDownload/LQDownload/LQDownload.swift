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
	var stream: OutputStream?
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
	func fileDownloadSize(_ url: String) -> Int {
		var filesize: Int?
		do {
			let attr = try FileManager.default.attributesOfItem(atPath: fileFullPath(url))
			filesize = attr[FileAttributeKey.size] as? Int
		} catch {
			debugPrint("Error: \(error)")
		}
		guard let size = filesize else {
			return 0
		}
		return size
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
	func download(_ urlString: String, progress: @escaping (_ cur: Int, _ end: Int, _ progress: Double) -> Void, state: @escaping (LQDownloadState) -> Void) {
		if isComplate(urlString) {
			state(.complete)
			debugPrint("(￣.￣)该资源已下载完成")
			return
		}
		//任务已存在 执行 继续或暂停
		guard let fileName = fileName(urlString) else { return }
		if let _ = tasks[fileName] {
			handle(urlString)
			return
		}
		
		//创建任务
		createDownloadDirectory()
		
		
		let config = URLSessionConfiguration.default
		let operationQueue = OperationQueue()
		let session = URLSession(configuration: config, delegate: self, delegateQueue: operationQueue)
		
		//创建流
		let stream = OutputStream(toFileAtPath: fileFullPath(urlString), append: true)
		
		//创建请求头
		guard let url = URL(string: urlString) else {
			return
		}
		var request = URLRequest(url: url)
		
		//设置请求头
		let fileSize = fileDownloadSize(urlString)
		let range = String(format: "bytes=%zd-", fileSize)
		request.addValue(range, forHTTPHeaderField: "Range")
		
		//创建一个Data任务
		let task = session.dataTask(with: request)
		let taskIdentifier = arc4random() % (arc4random() % 10000 + arc4random() % 10000)
		task.setValue(taskIdentifier, forKey: "taskIdentifier")
		
		//保存任务
		self.tasks.updateValue(task, forKey: fileName)
		
		let sessionModel = LQSessionModel(stream: stream, url: urlString, totalLength: fileSize, progressBlock: progress, stateBlock: state)
		
		self.sessionModels.updateValue(sessionModel, forKey: task.taskIdentifier)
		
		start(urlString)
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

extension LQDownload: URLSessionDataDelegate {
	
	//接收到相应
	func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
		
		guard var sessionModel = getSessionModel(dataTask.taskIdentifier)  else {
			return
		}
		//打开流
		sessionModel.stream?.open()
		//获取本次请求 返回数据的总长度
		let totalLength = response.expectedContentLength + fileDownloadSize(sessionModel.url)
		
		sessionModel.totalLength = Int(totalLength)
		
		//存储总长度
		var dict = NSMutableDictionary(contentsOf: URL(fileURLWithPath: totalLengthFullPath()))
		if dict == nil {
			dict = NSMutableDictionary()
		}
		dict?[fileName(sessionModel.url) ?? "错误URL"] = Int(totalLength)
		
		//接受这个请求, 允许接受服务器的数据
		completionHandler(.allow)
	}
	
	//接受到服务器返回的数据
	func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
		guard let sessionModel = getSessionModel(dataTask.taskIdentifier) else {
			return
		}
		
		//写入数据
		data.withUnsafeBytes { (unsafePointer: UnsafePointer<UInt8>) -> Void in
			sessionModel.stream?.write(unsafePointer, maxLength: data.count)
		}
		
		//更新下载进度
		let receivedSize = fileDownloadSize(sessionModel.url)
		let expectedSize = sessionModel.totalLength
		let progress = Double(receivedSize) / Double(expectedSize)
		
		sessionModel.progressBlock(receivedSize, expectedSize, progress)
	}
	
	//请求完毕 (成功/失败)
	func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
		guard var sessionModel = getSessionModel(task.taskIdentifier) else {
			return
		}
		
		if isComplate(sessionModel.url) {
			//下载完成
			sessionModel.stateBlock(.complete)
		} else {
			//下载失败
			sessionModel.stateBlock(.failed)
		}
		
		//关闭流
		sessionModel.stream?.close()
		sessionModel.stream = nil
		
		//清除任务
		guard let fileName = fileName(sessionModel.url) else {
			return
		}
		tasks.removeValue(forKey: fileName)
		sessionModels.removeValue(forKey: task.taskIdentifier)
	}
}

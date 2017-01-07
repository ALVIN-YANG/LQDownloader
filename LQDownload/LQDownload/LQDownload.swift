//
//  LQDownload.swift
//  LQDownload
//
//  Created by 杨卢青 on 2017/1/6.
//  Copyright © 2017年 杨卢青. All rights reserved.
//

import UIKit

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
	
	//文件已下载长度
	func fileDownloadLength(_ url: String) -> UInt64? {
		var filesize: UInt64?
		do {
			let attr = try FileManager.default.attributesOfItem(atPath: fileFullPath(url))
			filesize = attr[FileAttributeKey.size] as? UInt64
		} catch {
			debugPrint("Error: \(error)")
		}
		return filesize
	}
	
	//存储文件总长度的文件路径
	func totalLengthFullPath() -> String{
		return downloadDirectory().appending("/totalLength.plist")
	}
	
	lazy var tasks = { return [String: String]() }()
	lazy var sessionModels = { return [String: String]() }()
	
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
}

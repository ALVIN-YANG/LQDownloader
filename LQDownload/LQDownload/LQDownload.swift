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
	//文件全路径
	func fileFullPath(_ fileName: String) -> String {
		return downloadDirectory() + "\(fileName)"
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
	
}

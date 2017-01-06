//
//  LQDownload.swift
//  LQDownload
//
//  Created by 杨卢青 on 2017/1/6.
//  Copyright © 2017年 杨卢青. All rights reserved.
//

import UIKit

class LQDownload: NSObject {
	func downloadDirectory() -> String {
		return NSHomeDirectory() + "/TTDownload"
	}
	
	func fileFullPath(_ fileName: String) -> String {
		return downloadDirectory() + "\(fileName)"
	}
	
	
}

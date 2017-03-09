//
//  String+Md5.swift
//  SwiftTips
//
//  Created by KON on 2017/3/9.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

extension String {
	var MD5: String {
		var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
		
		if let data = data(using: .utf8) {
			data.withUnsafeBytes({ (bytes) -> Void in
				CC_MD5(bytes, CC_LONG(data.count), &digest)
			})
		}
		
		var digestHex = ""
		
		for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
			digestHex += String(format: "%02x", digest[index])
		}
		
		return digestHex
	}
}

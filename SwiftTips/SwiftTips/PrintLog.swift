//
//  PrintLog.swift
//  SwiftTips
//
//  Created by 杨卢青 on 2017/3/12.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

func printInfo<T>(_ message: T,
								
								file: String = #file,
								
								method: String = #function,
								
								line: Int = #line) {
	
	#if DEBUG
	
	print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
	
	#endif
}

func printLog<T>(_ message: T) {
  #if DEBUG
  
  print (message)
  
  #endif
}

//
//  Delay.swift
//  SwiftTips
//
//  Created by KON on 2017/3/6.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit
import Foundation

/*
问题:
1. @escaping()-> ()

2.
*/

typealias Task = (_ cancel: Bool) -> Void



func delay(_ time: TimeInterval, task: @escaping()-> ()) -> Task? {
	
	func dispatch_later(block: @escaping()-> ()) {
		let t = DispatchTime.now() + time
		DispatchQueue.main.asyncAfter(deadline: t, execute: block)
	}
	
	var closure: ( ()-> Void )? = task
	
	var result: Task?
	
	let delayedClosure: Task = {
		cancel in
		
		if let internalClosure = closure {
			if (cancel == false) {
				DispatchQueue.main.async(execute: internalClosure)
			}
		}
		
		closure = nil
		
		result = nil
	}
	
	result = delayedClosure
	
	dispatch_later {
		if let delayedClosure = result {
			
			delayedClosure(false)
			
		}
	}
	
	
	return result
}

func cancel(_ task: Task?) {
	task?(true)
}

func printLog<T>(message: T, file: String = #file, method: String = #function, line: Int = #line) {
	print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message))")
}


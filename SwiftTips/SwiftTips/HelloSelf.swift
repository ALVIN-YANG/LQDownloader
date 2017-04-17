//
//  HelloSelf.swift
//  SwiftTips
//
//  Created by 杨卢青 on 2017/3/15.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

protocol Hello  {
	func hello()
}

extension Hello where Self: UIView {
	func doSomething() {}
}

class HelloClass: Hello {
	
	func hello() {
		printLog("ds")
	}
}

class someView: UIView {}

extension someView: Hello {
	internal func hello()  {
		printLog("dsad")
	}

	func doSomething() {
		printLog("f")
	}
}

func testHelloSelf() {
	let ret = HelloClass.init().hello()
	
	printLog("ret: \(ret)")
}

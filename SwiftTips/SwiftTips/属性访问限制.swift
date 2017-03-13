//
//  属性访问限制.swift
//  SwiftTips
//
//  Created by 杨卢青 on 2017/3/12.
//  Copyright © 2017年 KON. All rights reserved.
//

import UIKit

/**
	Swift 中由低至高提供了 

	private, fileprivate, internal, public, open 

	五种访问控制的权限

	public 和 open 的区别在于，

	只有被 open 标记的内容才能在别的框架中被继承或者重写

*/

//可以通过下面的写法将读取和设置的控制权限分开：

public class rightTest {
	
	//设置权限私有 get权限internal
	private(set) var name: String?
	
	//设置权限私有 get权限public
	public private(set) var age: String?
}

